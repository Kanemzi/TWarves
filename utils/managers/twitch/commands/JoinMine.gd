extends ChatCommand

class_name JoinMineCommand

export(NodePath) var dwarf_manager : NodePath
export(Resource) var dwarf_scene : Resource

func _action(params) -> void:
	
	print("join mine called ! ")
	
	var name = params[0]
	var player := PlayersManager.add(name)
	var dwarf = dwarf_scene.instance()
	dwarf._init(name)
	get_node(dwarf_manager).add_new(dwarf)