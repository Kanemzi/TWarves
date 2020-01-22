extends Node2D

export(bool) var SHOW_CONFIG := false

onready var credentials_popup : WindowDialog = $CredentialsPopup
onready var chat_interface : Gift = $ChatInterface

func _ready() -> void:
	if SHOW_CONFIG:
		credentials_popup.popup()
		yield(credentials_popup, "popup_hide")
	chat_interface.start()
	print("configuration done !")