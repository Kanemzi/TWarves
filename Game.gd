extends Node2D
class_name Game
# Classe de base du jeu
# Gère en particulier la sauvegarde et le chargement des données du jeu

const SAVE_PATH := "res://data/save.cfg"

export(bool) var _show_config := false
export(float) var _autosave_delay := 30.0

var _save_file : File

onready var credentials_popup := $CredentialsPopup as WindowDialog
onready var chat_interface := $ChatInterface as ChatInterface
onready var players_manager := $Players as PlayersManager
onready var cave_scene := $SceneContainer/Scene/Cave as Cave
onready var gui := $GUI as CanvasLayer
onready var autosave_timer := $AutosaveTimer as Timer

func _ready() -> void:
	if _show_config:
		credentials_popup.popup()
		yield(credentials_popup, "popup_hide")
	chat_interface.start()
	load_game()
	autosave_timer.wait_time = _autosave_delay
	autosave_timer.start()
	randomize()


func _notification(what: int):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_game()
		get_tree().quit()


func save_game() -> void:
	_save_file = File.new()
	_save_file.open(SAVE_PATH, File.WRITE)
	
	var players := get_tree().get_nodes_in_group("Players")
	for o in players:
		var player := o as Player
		var save_data := to_json(player.get_save_data())
		_save_file.store_line(save_data)
	_save_file.close()


func load_game() -> void:
	_save_file = File.new()	
	if not _save_file.file_exists(SAVE_PATH):
		return
	
	_save_file.open(SAVE_PATH, File.READ)
	while not _save_file.eof_reached():
		var data = parse_json(_save_file.get_line())
		if not data:
			break
		
		var display_name := str(data["display_name"])
		var user_id := str(data["user_id"])
		var golden_nuggets_total := int(data["golden_nuggets_total"])
		var player := players_manager.add(user_id, display_name)
		player.golden_nuggets_total = golden_nuggets_total
	_save_file.close()
