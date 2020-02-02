extends RigidBody2D
class_name ItemDrop
# Classe de base représentant un item droppé au sol dans la mine
# Un item droppé est soumis à la gravité

func _physics_process(delta: float) -> void:
	pass


# Arrête les mouvements de l'objet définitivement et l'aligne au pixel
func stop_snap() -> void:
	mode = RigidBody2D.MODE_STATIC
	sleeping = true
	position = Vector2(int(position.x), int(position.y))
