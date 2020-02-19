const mongoose = require('mongoose')

let playerSchema = new mongoose.Schema({
  display_name: String,
  user_id: String,
  golden_nuggets: {type: Number, default: 0},
  custom_elements: {
    skin_color: {type: String, default: '#f6ca9f'},
    chest_color: {type: String, default: '#8e251d'},
    pants_color: {type: String, default: '#391f21'},
    boots_color: {type: String, default: '#1c121c'},
    beard_color: {type: String, default: '#b4b4b4'}
  }
})

let Player = mongoose.model('Player', playerSchema)

module.exports = Player;