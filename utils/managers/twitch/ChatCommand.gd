extends Node

class_name ChatCommand

export(String) var command_name : String

var root : Node

func _ready() -> void:
	root = get_tree().get_root()

func _action(params) -> void:
	return
