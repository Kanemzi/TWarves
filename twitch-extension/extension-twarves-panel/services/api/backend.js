const Hapi = require('hapi')
const ext = require('commander')
require('dotenv').config({path: '../.env'})

const globals = require('../globals')
const tdlServer = require('../client-link/TDLServer')

ext.
  version(require('../../package.json').version).
  option('-s, --secret <secret>', 'Extension secret').
  option('-c, --client-id <client_id>', 'Extension client ID').
  option('-o, --owner-id <owner_id>', 'Extension owner ID').
  parse(process.argv)

globals.OWNER_ID = ext['ownerId']
globals.SECRET = Buffer.from(ext['secret'], 'base64')
globals.CLIENT_ID = ext['clientId']

const serverOptions = {
  host: 'localhost',
  port: 3000,
  routes: {
    cors: {
      origin: ['*'],
    },
  },
}

;(async() => {
  console.log("[TWarves] Starting...")
  const server = new Hapi.Server(serverOptions)

  // récupère la dernière mise à jour du leaderboard
  server.route({
      path: '/refresh-leaderboard',
      method: 'GET',
      handler: require('./handlers/refreshLeaderboard')
  })

  await server.start()
  console.log("[TWarves] Server started !")
})()