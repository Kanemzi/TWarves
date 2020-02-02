extends ItemDrop
class_name GoldenNugget
# Classe représentant une pépite d'or droppée par un nain

const MAX_BOUNCES = 3

export(float) var min_speed := 10.0
export(float) var spread := 0.0

# = true quand la pépite est immobile et peut être ramassée
var safe_to_pick := false
var _bounces := 0

func _ready():
	var angle := rand_range(-5*PI/6, -PI/6)
	var speed := rand_range(0.0, min_speed + spread)
	var vel := Vector2(cos(angle), sin(angle)) * speed
	apply_impulse(Vector2.ZERO, vel)
	add_to_group("golden_nugget")


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()


func _on_GoldenNugget_body_entered(body: Node) -> void:
	_bounces += 1
	if _bounces == MAX_BOUNCES:
		stop_snap()
		safe_to_pick = true
