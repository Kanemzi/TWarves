extends Node2D
class_name WarningIcon
# Classe représentant une icone d'alerte

var _scale: int

onready var sprite := $Sprite as Sprite
onready var animator := $AnimationPlayer as AnimationPlayer

func _ready() -> void:
	animator.play("warn")
	_scale = int(ConfigManager.get_setting("graphics", "scene_scale_factor"))


func update_position(pos: Vector2) -> void:
	position.x = pos.x * _scale
	position.y = pos.y * _scale


func _on_Dwarf_caves_exited() -> void:
	queue_free()


func _on_Dwarf_moved(new_position: Vector2) -> void:
	update_position(new_position)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name != "warn":
		return
	queue_free()
