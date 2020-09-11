extends ChatCommand
class_name HelpCommand
# commande : !twarves
# description : envoie une liste des commandes du jeu dans le chat

export(float) var min_time_between_help = 2.0

var _last_help_sent_time := 0

func _action(cmd: CommandInfo, args: PoolStringArray) -> void:
	var time = OS.get_ticks_msec()
	if (time - _last_help_sent_time) / 1000 < min_time_between_help:
		return
	
	_game.chat_interface.chat(Strings.Bot.COMMAND_HELP_MESSAGE)
	_last_help_sent_time = time

