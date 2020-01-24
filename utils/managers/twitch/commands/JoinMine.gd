extends ChatCommand
class_name JoinMineCommand

func _action(cmd : CommandInfo, args : PoolStringArray) -> void:
	var players_manager := (owner as Scene).players_manager as PlayersManager
	var dwarf_queue := (owner as Scene).cave_scene.dwarf_queue as DwarfQueue
	
	var user_id := str(cmd.sender_data.tags['user-id'])
	var display_name := str(cmd.sender_data.tags['display-name'])
	var player := players_manager.add(user_id, display_name)
	
	if not player.is_in_cave() :
		var dwarf := player.create_dwarf()
		dwarf_queue.add(dwarf)
	else:
		(owner as Scene).chat_interface.chat("Vous êtes déjà dans la mine " + display_name)