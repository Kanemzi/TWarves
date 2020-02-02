extends ChatCommand
class_name PickCommand
# commande : !pick
# description : permet de demander à son nain ramasser des pépites au sol,
# lorsqu'il n'y a plus de pépites disponibles, le nain retourne miner

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
		var icons := _game.gui.get_node("ActionIcons") as GUIActionIcons
		icons.spawn_action_icon_for(dwarf, "pick")
		dwarf.state_machine.transition_to("Move/Pick")
