extends ChatCommand

class_name JoinMineCommand

func _action(cmd : CommandInfo, args : PoolStringArray) -> void:
	
	var players_manager : PlayersManager = owner.players_manager
	var dwarf_queue : DwarfQueue = owner.cave_scene.dwarf_queue
	
	var display_name : String = cmd.sender_data.tags['display-name']
	var user_id : String = cmd.sender_data.tags['user-id']
	var player := players_manager.add(user_id, display_name)
	
	if not player.is_in_cave() :
		var dwarf = player.create_dwarf()
		dwarf_queue.add(dwarf)
	else:
		owner.chat_interface.chat("Vous êtes déjà dans la mine " + display_name)