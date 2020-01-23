extends Node2D

"""
Modifie la direction du sprite
direction >= 0 => droite
direction < 0 => gauche
"""
func set_direction(direction: int) -> void:
	if direction < 0:
		scale.x = -1
	else:
		scale.x = 1