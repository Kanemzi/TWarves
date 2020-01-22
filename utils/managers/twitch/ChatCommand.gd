extends Node

class_name ChatCommand

export(int) var max_args := -1
export(int) var min_args := 0
export(Gift.PermissionFlag) var permission_level := Gift.PermissionFlag.EVERYONE
export(Gift.WhereFlag) var where := Gift.WhereFlag.CHAT

func _ready() -> void:
	pass

func _action(params) -> void:
	return
