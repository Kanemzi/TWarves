
extends KinematicBody2D
class_name Dwarf

signal moved(new_position)
signal caves_exited
signal pickaxe_used

signal nuggets_got(amount)
signal nuggets_lost(amount)

onready var animator := $AnimationPlayer as AnimationPlayer
onready var state_machine := $StateMachine as StateMachine
onready var sprite := $Sprite as DwarfSprite
onready var exit_timer := $ExitTimer as Timer

var display_name : String
var must_exit := false
var golden_nuggets := 0

func init(_display_name : String = "___dummy___") -> void :
	self.display_name = _display_name


func _ready() -> void:
	var max_time := float(ConfigManager.get_setting("gameplay", "max_time_in_caves"))
	print("max time : " + str(max_time))
	exit_timer.wait_time = max_time
	exit_timer.start()


# Donne un certain nombre de pépites d'or à un joueur
func give_nuggets(amount : int) -> void:
	golden_nuggets += amount
	if amount != 0:
		emit_signal("nuggets_got", amount)


# Le nain lache [amount] pépites d'or au sol
# Si le nain possède moins de [amount] pépites, il lache toutes ses pépites
func drop_nuggets(amount : int) -> void:
	golden_nuggets -= amount
	if amount != 0:
		var overflow := 0
		if golden_nuggets < 0:
			overflow = abs(golden_nuggets)
		emit_signal("nuggets_lost", amount - overflow)
	

# Fonction exécutée lorsque la pioche du nain frappe un filon
func _pickaxe_animation_hit() -> void:
	emit_signal("pickaxe_used")


# Fonction exécutée lorsque le nain a terminé son temps autorisé dans la mine
func _on_ExitTimer_timeout() -> void:
	self.must_exit = true
	state_machine.transition_to("Move/Exit")
	print(display_name + " must exit")