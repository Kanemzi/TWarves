const globals = require('../../globals')
const {decodeJWT} = require('../../helper')

module.exports = (req, res) => {
  const payload = decodeJWT(req.headers.authorization)
  return payload
}