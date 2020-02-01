extends Node2D
class_name DisplayNameLabel
# Classe représentant un label de pseudo de nain

var _scale: int

onready var label := $Center/Label as Label

func _ready() -> void:
	_scale = int(ConfigManager.get_setting("graphics", "scene_scale_factor"))


func set_display_name(display_name: String) -> void:
	label.text = display_name


func update_position(pos: Vector2) -> void:
	position.x = pos.x * _scale
	position.y = pos.y * _scale


func _on_Dwarf_caves_exited() -> void:
	queue_free()


func _on_Dwarf_moved(new_position: Vector2) -> void:
	update_position(new_position)
