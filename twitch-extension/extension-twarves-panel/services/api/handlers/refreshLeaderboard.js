const globals = require('../../globals')
const {decodeJWT} = require('../../helper')
const Player = require('../../models/player')

module.exports = async (req, res) => {
  const payload = decodeJWT(req.headers.authorization)
	console.log('get leaderboard : ' + JSON.stringify(payload))
	let leaderboard = await getLeaderboard()
  return leaderboard
}

/**
 * Envoie une requête à la base de données pour récupérer le top 10 du classement
 */
const getLeaderboard = async () => {
	return new Promise((resolve, reject) => {
		Player.find()
		.sort({golden_nuggets: -1})
		.limit(10)
		.select({display_name: 1, golden_nuggets: 1})
		.then(resolve, reject)
	})
}