extends Node

signal config_loaded

const SAVE_PATH := "res://data/config.cfg"

var _config_file := ConfigFile.new()

var _settings := {
	"credentials" : {
		"bot_nick": "",
		"client_id": "",
		"channel_name": "",
		"oauth": ""
	}
}

func _ready() -> void:
	load_settings()
	print("settings : %s" % _settings)

func save_settings() -> void:
	for section in _settings.keys():
		for key in _settings[section].keys():
			_config_file.set_value(section, key, _settings[section][key])
	var error := _config_file.save(SAVE_PATH)
	if error :
		print("Error : " + str(error))

func load_settings() -> void:
	var error := _config_file.load(SAVE_PATH)
	if error != OK:
		print("Error loading settings. Error code : %s" % error)
		return

	for section in _settings.keys():
		for key in _settings[section].keys():
			var default = _settings[section][key]
			_settings[section][key] = _config_file.get_value(section, key, default)
	
	emit_signal("config_loaded")

func get_setting(category: String, key: String):
    return _settings[category][key]

func set_setting(category: String, key: String, value) -> void:
    _settings[category][key] = value