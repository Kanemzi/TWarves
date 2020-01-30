extends ChatCommand

class_name DwarfMoveCommand

func _action(cmd : CommandInfo, args : PoolStringArray) -> void:
	
	var players_manager : PlayersManager = owner.players_manager
	
	var display_name : String = cmd.sender_data.tags['display-name']
	var user_id : String = cmd.sender_data.tags['user-id']
	
	if not players_manager.exists(user_id):
		owner.chat_interface.chat("Entrez d'abord dans la mine " + display_name + "!")
		return
	
	var player := players_manager.get(user_id)
	
	if not player.is_in_cave() :
		owner.chat_interface.chat("Entrez d'abord dans la mine " + display_name + "!")
		return
	else:
		owner.chat_interface.chat("Vous vous déplacez " + display_name + "! C'est déjà pas mal Kappa")
		player.dwarf.target(Vector2(float(args[0]), 0))
