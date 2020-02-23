const Player = require('./player')

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

exports.getLeaderboard = getLeaderboard