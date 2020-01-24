extends ChatCommand
class_name JoinMineCommand

func _action(cmd : CommandInfo, args : PoolStringArray) -> void:
	var players_manager := (owner as Game).players_manager as PlayersManager
	var dwarf_queue := (owner as Game).cave_scene.dwarf_queue as DwarfQueue
	
	var user_id := str(cmd.sender_data.tags['user-id'])
	var display_name := str(cmd.sender_data.tags['display-name'])
	var player := players_manager.add(user_id, display_name)
	
	if not player.is_in_cave() :
		var dwarf := player.create_dwarf()
		dwarf_queue.add(dwarf)
		
		# création du label de pseudo
		var pseudo := DisplayNameLabel.new(display_name)
		dwarf.connect("moved", pseudo, "_on_Dwarf_moved")
		dwarf.connect("caves_exited", pseudo, "_on_Dwarf_caves_exited")
		(owner as Game).gui.get_node("DisplayNames").add_child(pseudo)
	else:
		(owner as Game).chat_interface.chat("Vous êtes déjà dans la mine " + display_name)