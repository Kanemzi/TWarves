extends Label
class_name DisplayNameLabel

const OFFSET := Vector2(0, 0)
const FONT := preload("res://interface/fonts/display_name_font.tres")

var _scale : int

func _init(display_name: String) -> void:
	text = display_name
	add_font_override("font", FONT)
	_scale = int(ConfigManager.get_setting("graphics", "scene_scale_factor"))

func update_position(position: Vector2) -> void:
	margin_left = (position.x + OFFSET.x) * _scale - (rect_size.x / 2)
	margin_top = (position.y + OFFSET.y) * _scale

func _on_Dwarf_caves_exited() -> void:
	queue_free()

func _on_Dwarf_moved(new_position: Vector2) -> void:
	update_position(new_position)
