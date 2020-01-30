extends Node2D
class_name ActionIcon

const icon_indexes := {
	"exit": 0,
	"mine": 1,
	"stun": 2,
	"trap": 3
}

var _scale : int

onready var sprite := $Sprite as Sprite
onready var animator := $AnimationPlayer as AnimationPlayer
onready var timer := $Timer as Timer

func _ready():
	animator.play("open")
	timer.start()
	_scale = int(ConfigManager.get_setting("graphics", "scene_scale_factor"))


func set_icon(icon_name : String) -> void:
	if not icon_name in icon_indexes:
		icon_name = "mine"
	sprite.frame = icon_indexes[icon_name]


func update_position(pos: Vector2) -> void:
	position.x = pos.x * _scale
	position.y = pos.y * _scale


func _on_Dwarf_caves_exited() -> void:
	queue_free()


func _on_Dwarf_moved(new_position: Vector2) -> void:
	visible = true
	update_position(new_position)


func _on_Timer_timeout() -> void:
	animator.play("close");


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name != "close":
		return
	queue_free()
