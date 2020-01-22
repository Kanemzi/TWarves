extends WindowDialog

onready var validate_button := $Layout/Validate
onready var bot_nick := $Layout/Form/BotNickEdit
onready var client_id := $Layout/Form/ClientIdEdit
onready var channel_name := $Layout/Form/ChannelNameEdit
onready var oauth := $Layout/Form/OauthEdit

func _on_Validate_pressed():
	ConfigManager.set_setting("credentials", "bot_nick", bot_nick.get_text())
	ConfigManager.set_setting("credentials", "client_id", client_id.get_text())
	ConfigManager.set_setting("credentials", "channel_name", channel_name.get_text())
	ConfigManager.set_setting("credentials", "oauth", oauth.get_text())
	ConfigManager.save_settings()
	hide()

func _on_CredentialsPopup_about_to_show():
	bot_nick.set_text(ConfigManager.get_setting("credentials", "bot_nick"))
	client_id.set_text(ConfigManager.get_setting("credentials", "client_id"))
	channel_name.set_text(ConfigManager.get_setting("credentials", "channel_name"))
	oauth.set_text(ConfigManager.get_setting("credentials", "oauth"))
	get_tree().paused = true
	get_tree().get_root().get_node("Game").set_modulate(Color.darkgray)

func _on_CredentialsPopup_popup_hide():
	get_tree().paused = false
	get_tree().get_root().get_node("Game").set_modulate(Color.white)
