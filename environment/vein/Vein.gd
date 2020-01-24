tool
extends Area2D
class_name Vein

export(int, 1, 3, 1) var tier := 1 setget set_tier
export(float) var mining_distance := 16.0

onready var sprite := $Sprite as Sprite

func _ready() -> void:
	update_texture()

func set_tier(value: int) -> void:
	if tier != value:
		tier = value
		if sprite:
			update_texture()

func update_texture() -> void:
	sprite.set_texture(load("res://environment/vein/%d.png" % tier))