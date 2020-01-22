extends Gift

onready var command_list = $Commands.get_children()

func _ready() -> void:
	# register all commands
	for command in command_list :
		print("register " + command.name.to_lower())
		add_command(command.name.to_lower(), command, "_action",
				command.max_args, 
				command.min_args, 
				command.permission_level, 
				command.where)


"""
Se connecte au chat twitch avec les credentials entrés dans la popup
"""
func start() -> void:
	var channel : String = ConfigManager.get_setting("credentials", "channel_name")
	var oauth : String = ConfigManager.get_setting("credentials", "oauth")
	var bot_nick : String = ConfigManager.get_setting("credentials", "bot_nick")
	print(oauth)
	if channel == "" or oauth == "" or bot_nick == "" :
		return
	
	connect_to_twitch()
	yield(self, "twitch_connected")
	authenticate_oauth(bot_nick, oauth)
	join_channel(channel)
	chat("Bienvenue !")