extends ChatCommand

class_name QueueAdvanceCommand

export(NodePath) var dwarf_manager : NodePath

func _action(cmd : CommandInfo, args : PoolStringArray) -> void:
	var dwarf = get_node(dwarf_manager).free_next()
	dwarf._init(name)
	dwarf.move_to_point(Vector2(randi() % 180 + 20, 0))