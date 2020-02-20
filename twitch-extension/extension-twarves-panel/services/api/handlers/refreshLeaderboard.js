const globals = require('../../globals')
const {decodeJWT} = require('../../helper')

module.exports = (req, res) => {

  console.log(req.headers)

  const payload = decodeJWT(req.headers.authorization)

  return payload
}