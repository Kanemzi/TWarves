extends Node2D

export(bool) var SHOW_CONFIG := false

onready var credentials_popup : WindowDialog = $CredentialsPopup
onready var chat_interface : Gift = $ChatInterface
onready var players_manager := $Players
onready var cave_scene := $SceneContainer/Scene/Cave

func _ready() -> void:
	if SHOW_CONFIG:
		credentials_popup.popup()
		yield(credentials_popup, "popup_hide")
	chat_interface.start()
	
#func _process(delta: float) -> void:
#	print("fps : " + str(Engine.get_frames_per_second()))