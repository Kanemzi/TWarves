extends Node2D
class_name GoldCounter
# Classe représentant un compteur de pépites d'or

var counter := 0.0
var displayed_counter := counter

var _scale: int

onready var label := $Center/Label as Label
onready var increment := $Increment as Tween
onready var particles := $GoldParticles as Particles2D

func _ready() -> void:
	_scale = int(ConfigManager.get_setting("graphics", "scene_scale_factor"))

func _on_Dwarf_nuggets_got(amount: float) -> void:
	counter += amount
	particles.amount = amount
	particles.emitting = true
	increment.interpolate_property(self, "displayed_counter", 
			displayed_counter, counter, amount * 0.05, 
			Tween.TRANS_CUBIC, Tween.EASE_IN)
	increment.start()


func update_position(pos: Vector2) -> void:
	position.x = pos.x * _scale
	position.y = pos.y * _scale


func _on_Dwarf_caves_exited() -> void:
	queue_free()


func _on_Dwarf_moved(new_position: Vector2) -> void:
	update_position(new_position)


func _on_Increment_tween_step() -> void:
	label.text = str(int(displayed_counter))

