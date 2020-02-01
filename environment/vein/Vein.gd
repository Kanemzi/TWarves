tool
extends Area2D
class_name Vein
# Classe représentant un filon d'or

export(int, 1, 3, 1) var tier := 1 setget set_tier
export(float) var mining_distance := 16.0
export(float) var mining_drop_rate := 1.0
export(int) var mining_nugget_min := 1
export(int) var mining_nugget_max := 2

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


# Retourne une quantité aléatoire de pépites d'or en fonction
# des probabilités de drop définies dans l'éditeur
func get_nugget_amount() -> int:
	var amount = 0
	if randf() < mining_drop_rate:
		if mining_nugget_min == mining_nugget_max:
			amount = mining_nugget_min
		else:
			var amout_range := (mining_nugget_max - mining_nugget_min + 1)
			amount = randi() % amout_range + mining_nugget_min
	return amount


# Retourne l'espérence de gain par coup de pioche sur le filon
func get_expected_value() -> float:
	return (mining_nugget_max + mining_nugget_min) / 2 * mining_drop_rate
