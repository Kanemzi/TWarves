extends ItemDrop
# Classe représentant une pépite d'or droppée par un nain

export(float) var min_speed := 10.0
export(float) var spread := 0.0

func _ready():
	var angle := rand_range(-PI, 0)
	var speed := rand_range(0.0, min_speed + spread)
	var vel := Vector2(cos(angle), sin(angle)) * speed
	apply_impulse(Vector2.ZERO, vel)
	add_to_group("golden_nugget")


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
