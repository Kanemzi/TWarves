const db = require('../database')
const Player = require('../models/player')
const {Type, TDLMessage} = require('./TDLMessage')

db.connect()

let handlers = {}

/**
 * Réponse à une requête d'information pour un joueur souhaitant rejoindre la partie
 * 
 * Si le joueur existe en bd, on met à jour son pseudo si il a été changé puis on envoie un 
 * message au client contenant les informations du joueur.
 * 
 * Si l'utilisateur n'a jamais joué au jeu, on lui crée un profile par défaut avec ses 
 * identifiants puis on retourne ses informations
 */
handlers[Type.REQUEST_PLAYER_FOR_JOIN] = message => {
  let user_id = message.user_id
  let display_name = message.display_name
  
  if (!user_id || !display_name) return

  console.log('[TDL] Recherche du joueur ', message.display_name)

  // Recherche un joueur dont l'user_id correspond à l'user_id passé dans le message
  new Promise((resolve, reject) => {
    Player.findOne({user_id: user_id}).then(resolve, reject)
  })
  .then(player => {
    // Si le joueur n'est pas encore enregistré dans la base de données
    if (!player) {
      console.log('[TWarves Server] Nouveau joueur créé')
      new Player({user_id: user_id, display_name: display_name}).save()
    
    // Si le joueur existe déjà dans la base de données
    } else {
      console.log('[MongoDB] Joueur trouvé : ' + player)
      updateDisplayName(player, display_name)
      let playerData = new TDLMessage(Type.PLAYER_INFORMATION_FOR_JOIN, {player})
      playerData.send()
    }
  })
}

module.exports = handlers

/**
 * Met à jour le pseudo Twitch enregistré pour un utilisateur
 * 
 * @param {Player} player le joueur enregistré en base de données
 * @param {String} new_name le pseudo actuel du joueur
 */
const updateDisplayName = (player, new_name) => {
  if (player.display_name === new_name) return

  player.display_name = new_name
  player.save()
}  