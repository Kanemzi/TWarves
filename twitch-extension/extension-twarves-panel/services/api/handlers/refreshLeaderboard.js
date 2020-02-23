const globals = require('../../globals')
const {decodeJWT, pubsubBroadcast} = require('../../helper')
const {getLeaderboard} = require('../../models/leaderboard')

module.exports = async (req, res) => {
  const payload = decodeJWT(req.headers.authorization)
	console.log('[TWarves Server] Leaderboard requested')
	let leaderboard = await getLeaderboard()
  return leaderboard
}