const TDLServer = require('./TDLServer')
/**
 * Classe de gestion des messages échangés dans le protocole TDL
 * 
 * La classe fournit des builders pour les messages côté serveur
 */

// Enumère des différents types de messages traités dans le protocole TDL
const Type = {
  UNDEFINED : -1, // Type de message à structure libre non définie
  
  /* * * * Messages serveur * * * */
  
  /**
   * Retourne les informations concernant un joueur qui demande
   * à entrer dans la mine
   * 
   * {
   *    player: [Player] // les informations du joueur contenues dans la bdd
   * }
   */
  PLAYER_INFORMATION_FOR_JOIN: 0,


  /* * * * Messages client * * * */

  /**
   * Demande d'informations concernant un joueur (id, nom, golds, custom, ...)
   * qui demande à entrer dans la mine
   * 
   * {
   *    user_id: [id] // id du joueur dont il faut récupérer les informations
   *    display_name: [name] // le nom Twitch affiché du joueur
   * }
   */
  REQUEST_PLAYER_FOR_JOIN: 10,

  /**
   * Envoie au serveur le nombre de pépites d'or récoltées 
   * par le nain pendant la session
   * 
   * {
   *    user_id: [id] // id du joueur dont il faut sauvegarder les données
   *    golden_nuggets: [amount] // quantité de pépites d'or récoltées dans la mine
   * }
   */
  SAVE_PLAYER_DATA: 11,
}

const Status = {
	ERROR: -1,
	NOT_SENT: 0,
	SENT: 1
}

class TDLMessage {
	constructor(t, m) {
		this.message = m
		this.type = t
		this.status = Status.NOT_SENT
	}

	build_message() {
		return JSON.stringify({
			type: this.type,
			message: this.message
		})
	}

	send() {
		TDLServer.sendMessage(this)
		this.status = Status.SENT
		return this.status
	}
}

module.exports = {
	Type: Type,
	Status: Status,
	TDLMessage: TDLMessage
}