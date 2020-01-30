extends Node2D
class_name Game

const SAVE_PATH := "res://data/save.cfg"

export(bool) var SHOW_CONFIG := false

var _save_file : File

onready var credentials_popup := $CredentialsPopup as WindowDialog
onready var chat_interface := $ChatInterface as ChatInterface
onready var players_manager := $Players as PlayersManager
onready var cave_scene := $SceneContainer/Scene/Cave as Cave
onready var gui := $GUI as CanvasLayer

func _ready() -> void:
	if SHOW_CONFIG:
		credentials_popup.popup()
		yield(credentials_popup, "popup_hide")
	chat_interface.start()
	load_game()

func _notification(what):
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
		if not data :
			break
		
		var display_name = data["display_name"]
		var golden_nuggets_total = data["golden_nuggets_total"]
		var user_id = data["user_id"]
		var player := players_manager.add(user_id, display_name)
		player.golden_nuggets_total = golden_nuggets_total
	_save_file.close()
