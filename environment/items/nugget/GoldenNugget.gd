extends ItemDrop
class_name GoldenNugget
# Classe représentant une pépite d'or droppée par un nain

const MAX_BOUNCES = 3

export(float) var min_speed := 10.0
export(float) var spread := 0.0

# = true quand la pépite est immobile et peut être ramassée
var safe_to_pick := false
var _bounces := 0

func init(direction: Vector2):
#	var angle := rand_range(-2*PI/3, -PI/3)
	var angle := -PI/2
	var speed := rand_range(0.0, min_speed + spread)
	# la version du vecteur de direction de la pépite affectée par la direction
	# passée en paramètres
	var directed := (Vector2(cos(angle), sin(angle)) + direction).normalized()
	var vel = directed * speed
	apply_impulse(Vector2.ZERO, vel)


func _ready():
	add_to_group("golden_nugget")


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()


func _on_GoldenNugget_body_entered(body: Node) -> void:
	_bounces += 1
	if _bounces == MAX_BOUNCES:
		stop_snap()
		safe_to_pick = true
