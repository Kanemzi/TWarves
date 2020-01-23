extends Node
class_name StateMachine
"""
Interface de base d'une machine à états générique
"""

export(NodePath) var initial_state := NodePath()

onready var state: State = get_node(initial_state)

func _ready() -> void:
	yield(owner, "ready")
	state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


func _physics_process(delta: float) -> void:
	state.physics_process(delta)


"""
Change l'état actuel de la machine à états
"""
func transition_to(target_state: String, params := {}) -> void:
	if not has_node(target_state):
		return
	
	var new_state := get_node(target_state)
	
	state.exit()
	self.state = new_state
	state.enter(params)