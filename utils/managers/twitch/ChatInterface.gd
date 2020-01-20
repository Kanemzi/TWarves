extends Node

onready var cil = $TwiCIL
onready var commands = $Commands

var command_handlers := []

func _ready() -> void:
	# register all commands
	_start()
	for command in commands.get_children() :
		print("register " + command.command_name)
		cil.commands.add("!" + command.command_name, command, "_action", 1, true)

"""
Se connecte au chat twitch avec les credentials entrés dans la popup
"""
func _start() -> void:
	cil.set_logging(false)
	cil.connect_to_twitch_chat()
	cil.connect_to_channel(
		ConfigManager.get_setting("credentials", "channel_name"),
		ConfigManager.get_setting("credentials", "client_id"),
		ConfigManager.get_setting("credentials", "oauth"),
		ConfigManager.get_setting("credentials", "bot_nick")
	)
	cil.send_message("Bienvenue !")