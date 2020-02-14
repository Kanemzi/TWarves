const http = require('http')
const ws = require('ws').Server
require('dotenv').config()

const handlers = require('./handlers')

let wsServer = new ws({port: 5700})

wsServer.on('connection', (ws) => {
  console.log('new connection')
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
const sendMessage = (socket, type, message) => {
  let str = JSON.stringify({type: type, message: message});
  socket.send(str)
}

exports.sendMessage = sendMessage