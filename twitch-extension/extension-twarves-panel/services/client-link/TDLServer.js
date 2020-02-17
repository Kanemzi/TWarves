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


const handleMessage = message => {
  let json
  try {
    json = JSON.parse(message)
  } catch (e) {
    return console.error(e)
  }

  if (handlers[json.type] !== undefined)
    handlers[json.type](json.message)
}


/**
 * @param {String} message 
 */
const sendMessage = (message) => {
  if (client !== null)
		client.send(message)
}

exports.sendMessage = sendMessage