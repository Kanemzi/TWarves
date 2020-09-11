extends ChatCommand
class_name ExitMineCommand
# commande : !exitmine
# description : permet de quitter la mine avant la fin du temps limite

func _action(cmd: CommandInfo, args: PoolStringArray) -> void:
	var user_id := str(cmd.sender_data.tags['user-id'])
	var display_name := str(cmd.sender_data.tags['display-name'])
	
	if not _players.exists(user_id):
		_chat.chat(Strings.Bot.ERROR_NOT_IN_MINE % display_name)
		return
	
	var player := _players.get(user_id)

	if not player.is_in_cave():
		_chat.chat(Strings.Bot.ERROR_NOT_IN_MINE % display_name)
	elif player.dwarf.can_action:
		var dwarf := player.dwarf
		var state := dwarf.state_machine.state
		var icons := _game.gui.get_node("Icons") as GUIIcons
		icons.spawn_action_icon_for(dwarf, "exit")
		
		if not state.is_in_group("locking_state"):
			dwarf.state_machine.transition_to("Move/Exit")
		else:
			(state as DwarfLockingState).will_transition_to("Move/Exit")
