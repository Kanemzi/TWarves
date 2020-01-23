extends ChatCommand

class_name MineCommand

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
		var spot = 0
		if args.size() > 0:
			spot = int(args[0])
		player.dwarf.state_machine.transition_to("Dig", {spot=spot})
		owner.chat_interface.chat("Vous partez miner le spot " + str(spot) + ", " + display_name + " !")