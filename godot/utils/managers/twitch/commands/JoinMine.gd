extends ChatCommand
class_name JoinMineCommand
# commande : !joinmine
# description : permet de faire la queue pour entrer dans la mine

func _on_ready() -> void:
	_players.connect("player_joined", self, "_on_PlayerManager_player_joined")


func _action(cmd: CommandInfo, args: PoolStringArray) -> void:
	var user_id := str(cmd.sender_data.tags['user-id'])
	var display_name := str(cmd.sender_data.tags['display-name'])
	if _players.exists(user_id) or _players.is_in_queue(user_id):
		_game.chat_interface.chat(Strings.Bot.ERROR_ALREADY_IN_MINE % display_name)
		return
	
	_players.add(user_id, display_name)


# Exécuté lorsqu'un joueur vient de rejoindre la mine
func _on_PlayerManager_player_joined(player: Player) -> void:
	if not player.is_in_cave():
		var dwarf_queue := _game.cave.dwarf_queue as DwarfQueue
		var dwarf := player.create_dwarf()
		var names := _game.gui.get_node("DisplayNames") as GUIDisplayNames
		var gold_counters := _game.gui.get_node("GoldCounters") as GUIGoldCounters
		var icons := _game.gui.get_node("Icons") as GUIIcons
		dwarf_queue.add(dwarf)
		names.add_display_name_for(dwarf)
		gold_counters.add_gold_counter_for(dwarf)
		dwarf.connect("exit_forced", icons, "spawn_action_icon_for",
				[dwarf, "exit"], CONNECT_ONESHOT)
