/**
 * Module de base de l'implémentation côté serveur du protocole TDL (Twarves Distant Link)
 * permettant de gérer les interactions entre le jeu et la base de données distante
 */

const http = require('http')
const ws = require('ws').Server

require('dotenv').config()
console.log(process.env.DB_NAME)

const {Type, TDLMessage} = require('./TDLMessage')
const handlers = require('./handlers')

let client
let wsServer = new ws({port: 5700})

wsServer.on('connection', (ws) => {
	console.log('new connection')
	client = ws
	
	let message = new TDLMessage(Type.PLAYER_INFORMATION, {test: '123'})
	message.send()

  ws.on('message', (message) => {
    handleMessage(message)
  })
})

const handleMessage = message => {
  let json = JSON.parse(message)
  if (handlers[json.type] !== undefined)
    handlers[json.type](json.message)
}

/**
 * @param {WebSocket} socket 
 * @param {String} type 
 * @param {String} message 
 */
const sendMessage = (message) => {
  if (client !== undefined)
		client.send(message)
}

exports.sendMessage = sendMessage