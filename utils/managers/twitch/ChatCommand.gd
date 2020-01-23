extends Node

class_name ChatCommand

export(int) var max_args := -1
export(int) var min_args := 0
export(Gift.PermissionFlag) var permission_level := Gift.PermissionFlag.EVERYONE
export(Gift.WhereFlag) var where := Gift.WhereFlag.CHAT

# var chat_interface : ChatInterface

func _ready() -> void:
	pass


func prepare(cmd : CommandInfo, args : PoolStringArray) -> void:
	_action(cmd, args)

func _action(cmd : CommandInfo, args : PoolStringArray) -> void:
	return
