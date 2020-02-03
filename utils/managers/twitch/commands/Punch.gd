extends ChatCommand
class_name PunchCommand
# commande : !punch @[display_name]
# description : permet de demander à son nain d'en attaquer un autre

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
		var params := {}
		
		var target : Dwarf
		if args.size() > 0:
			var target_name := str(args[0])
			if args[0].begins_with("@"):
				target_name = target_name.substr(1)
			target = _find_dwarf_by_name(target_name)
			if target == null: 
				_chat.chat(Strings.Bot.ERROR_TARGET_NOT_IN_MINE % 
						[target_name, display_name])
				return
			elif target == dwarf:
				_chat.chat(Strings.Bot.ERROR_AUTO_PUNCH % display_name)
				return
		else:
			target = _find_richest_dwarf(dwarf)
			if target == null: 
				_chat.chat(Strings.Bot.ERROR_ALONE_IN_MINE % display_name)
				return
		
		params.target = target
		icons.spawn_action_icon_for(dwarf, "punch")
		dwarf.state_machine.transition_to("Move/Punch", params)


# Retourne le nain le plus riche actuellement dans la mine
# Retourne null si le nain est seul dans la mine
func _find_richest_dwarf(dwarf : Dwarf) -> Dwarf:
	var dwarves = get_tree().get_nodes_in_group("dwarves")
	var target : Dwarf = null
	var target_golds := 0
	for d in dwarves:
		if d == dwarf:
			continue
		if d.golden_nuggets > target_golds || target == null:
			target = d as Dwarf
			target_golds = d.golden_nuggets
	return target

# Retourne un nain en fonction du pseudo du joueur
# Retourne null si aucun nain correspondant n'est trouvé
func _find_dwarf_by_name(display_name: String) -> Dwarf:
	var dwarves = get_tree().get_nodes_in_group("dwarves")
	for d in dwarves:
		if str(d.display_name).to_lower() == display_name.to_lower():
			return d as Dwarf
	return null
