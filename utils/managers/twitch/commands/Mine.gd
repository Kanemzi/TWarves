extends ChatCommand
class_name MineCommand

func _action(cmd : CommandInfo, args : PoolStringArray) -> void:
	var players_manager := (owner as Scene).players_manager as PlayersManager
	
	var user_id := str(cmd.sender_data.tags['user-id'])
	var display_name := str(cmd.sender_data.tags['display-name'])
	
	if not players_manager.exists(user_id):
		(owner as Scene).chat_interface.chat("Entrez d'abord dans la mine " + display_name + "!")
		return
	
	var player := players_manager.get(user_id)
	
	if not player.is_in_cave() :
		(owner as Scene).chat_interface.chat("Entrez d'abord dans la mine " + display_name + "!")
		return
	elif player.dwarf.must_exit:
		return
	else:
		var params := {}
		if args.size() > 0:
			params.spot = int(args[0])
		player.dwarf.state_machine.transition_to("Move/Dig", params)