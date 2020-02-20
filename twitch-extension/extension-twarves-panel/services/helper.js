const Boom = require('boom')
const jwt = require('jsonwebtoken')
const request = require('request')
const globals = require('./globals')

module.exports = {
  decodeJWT: header => {
    if (header.startsWith(globals.BEARER_PREFIX)) {
      try  {
        const token = header.substring(globals.BEARER_PREFIX.length)
        return jwt.verify(token, globals.SECRET, {algorithms: ['HS256']})
      }  catch (e) {
        throw Boom.unauthorized('Invalid JWT')
      }
    }
    throw Boom.unauthorized('Invalid authorization header')
  },


  makeServerToken: channelId => {
    const payload = {
      exp: Math.floor(Date.now() / 1000) + globals.SERVER_TOKEN_DURATION,
      channel_id: channelId,
      user_id: globals.OWNER_ID,
      role: 'external',
      pubsub_perms: {
        send: ['*']
      }
    }
    return jwt.sign(payload, globals.SECRET, { algorithm: 'HS256' })
  },


  pubsubBroadcast: (channelId, message) => {
    const headers = {
      'Client-ID': globals.CLIENT_ID,
      'Content-Type': 'application/json',
      'Authorization': globals.BEARER_PREFIX + makeServerToken(channelId)
    }

    const body = JSON.stringify({
      content_type: 'application/json',
      message: message,
      targets: ['broadcast']
    })

    request(
      `https://api.twitch.tv/extensions/message/${channelId}`,
      {
        method: 'POST',
        headers,
        body,
      }
      , (err, res) => {
        if (err) {
          console.log('Error sending message to channel %s: %s', channelId, err)
        } else {
          console.log('Message to c:%s returned %s', channelId, res.statusCode)
        }
      }
    )
  }
}
