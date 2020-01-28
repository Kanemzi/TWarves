extends ChatCommand
class_name ExitMineCommand

func _action(cmd : CommandInfo, args : PoolStringArray) -> void:
	var players_manager := (owner as Game).players_manager as PlayersManager
	
	var user_id := str(cmd.sender_data.tags['user-id'])
	var display_name := str(cmd.sender_data.tags['display-name'])
	
	if not players_manager.exists(user_id):
		(owner as Game).chat_interface.chat("Entrez d'abord dans la mine " + display_name + "!")
		return
	
	var player := players_manager.get(user_id)
	
	if not player.is_in_cave() :
		(owner as Game).chat_interface.chat("Entrez d'abord dans la mine " + display_name + "!")
		return
	elif player.dwarf.must_exit:
		return
	else:
		var dwarf := player.dwarf
		# création de l'icon d'action
		var action_icons_layer := (owner as Game).gui.get_node("ActionIcons") as GUIActionIcons
		action_icons_layer.spawn_action_icon_for(dwarf, "mine")
		
		player.dwarf.state_machine.transition_to("Move/Exit")