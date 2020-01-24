extends Node2D
class_name Game

export(bool) var SHOW_CONFIG := false

onready var credentials_popup := $CredentialsPopup as WindowDialog
onready var chat_interface := $ChatInterface as ChatInterface
onready var players_manager := $Players as PlayersManager
onready var cave_scene := $SceneContainer/Scene/Cave as Cave

func _ready() -> void:
	if SHOW_CONFIG:
		credentials_popup.popup()
		yield(credentials_popup, "popup_hide")
	chat_interface.start()
