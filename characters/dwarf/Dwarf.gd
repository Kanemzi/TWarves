extends KinematicBody2D
class_name Dwarf

signal moved(new_position)
signal caves_exited
signal pickaxe_used

onready var animator := $AnimationPlayer as AnimationPlayer
onready var state_machine := $StateMachine as StateMachine
onready var sprite := $Sprite as DwarfSprite
onready var exit_timer := $ExitTimer as Timer

var display_name : String
var must_exit := false

func init(_display_name : String = "___dummy___") -> void :
	self.display_name = _display_name


func _ready() -> void:
	var max_time := float(ConfigManager.get_setting("gameplay", "max_time_in_caves"))
	print("max time : " + str(max_time))
	exit_timer.wait_time = max_time
	exit_timer.start()


"""
Fonction exécutée lorsque la pioche du nain frappe un filon
"""
func _pickaxe_animation_hit() -> void:
	emit_signal("pickaxe_used")


func _on_ExitTimer_timeout() -> void:
	self.must_exit = true
	state_machine.transition_to("Move/Exit")
	print(display_name + " must exit")