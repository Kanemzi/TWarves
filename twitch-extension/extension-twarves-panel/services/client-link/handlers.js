const db = require('../database')
const Player = require('../models/player')
db.connect()

module.exports = {
  leaderboard_update: message => {
    let user_id = message.user_id
    let golden_nuggets = message.golden_nuggets
    if (!user_id) return
    new Promise((resolve, reject) => {
      Player.findOne({user_id: user_id}).then(resolve, reject)
    })
    .then(player => {
      if (!player) {
        console.log('new player in leaderboard !')
        new Player({user_id: user_id, golden_nuggets: golden_nuggets}).save()
      } else {
        console.log('player : ' + player)
      }
    })
  }
}