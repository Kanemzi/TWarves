tool
extends StaticBody2D

class_name Vein

export(int, 1, 3, 1) var tier: int = 1 setget set_tier

onready var sprite: Sprite = $Sprite

func _ready() -> void:
	update_texture()

func set_tier(value) -> void:
	if tier != value:
		tier = value
		if sprite:
			update_texture()

func update_texture() -> void:
	sprite.set_texture(load("res://environment/vein/%d.png" % tier))