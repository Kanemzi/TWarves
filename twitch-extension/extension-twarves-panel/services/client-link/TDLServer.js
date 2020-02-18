/**
 * Module de base de l'implémentation côté serveur du protocole TDL (Twarves Distant Link)
 * permettant de gérer les interactions entre le jeu et la base de données distante
 */

const ws = require('ws').Server
require('dotenv').config()

const {Type, TDLMessage} = require('./TDLMessage')
const handlers = require('./handlers')

/*
  référence vers le client actuellement connecté au serveur
  il ne peut exister qu'un seul client connecté au serveur à la fois 
*/
let client = null
let wsServer = new ws({port: 5700})

wsServer.on('connection', (ws) => {
  console.log('new connection')
  // si le serveur est déjà connecté à un client, on interdit les nouvelles connexions
  if (client != null) {
    console.log('new connection refused')
    ws.close()
    return
  }
	client = ws
	
	let message = new TDLMessage(Type.PLAYER_INFORMATION, {test: '123'})
  message.send()

  ws.on('message', (message) => {
    handleMessage(message)
  })
  
  ws.onclose = () => {
    console.log("closed");
    client = null
  };
})


/**
 * Route un message TDL reçu vers le bon handler
 * (définis dans le fichier handlers.js)
 * @param {String} data 
 */
const handleMessage = data => {
  let json
  try {
    json = JSON.parse(data)
  } catch (e) {
    return console.error(e)
  }

  if (handlers[json.type] !== undefined
      && json.message !== undefined)
    handlers[json.type](json.message)
}


/**
 * Envoie un message via le protocole TDL
 * @param {TDLMessage} message 
 */
const sendMessage = (message) => {
  if (client !== null)
		client.send(message.build_message())
}

exports.sendMessage = sendMessage