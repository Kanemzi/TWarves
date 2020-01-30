extends Gift
class_name ChatInterface

onready var command_list := $Commands.get_children()

# onready var user_ids := $UserIds


# Se connecte au chat twitch avec les credentials entrés dans la popup
func start() -> void:
	_register_all_commands()
	
	var channel := ConfigManager.get_setting("credentials", "channel_name")
	var oauth := ConfigManager.get_setting("credentials", "oauth")
	var bot_nick := ConfigManager.get_setting("credentials", "bot_nick")
	
	if channel == "" or oauth == "" or bot_nick == "" :
		return
	
	connect_to_twitch()
	yield(self, "twitch_connected")
	authenticate_oauth(bot_nick, oauth)
	join_channel(channel)
	chat("Bienvenue dans TWarves!")


func _register_all_commands() -> void:
	for command in command_list :
		add_command(command.name.to_lower(), command, "prepare",
				command.max_args, 
				command.min_args, 
				command.permission_level, 
				command.where)
