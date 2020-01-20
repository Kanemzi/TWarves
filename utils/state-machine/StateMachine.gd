"""
Interface de base d'une machine à états générique utilisant un système de pile à états
"""
extends Node

class_name StateMachine

signal state_changed(state)

export(NodePath) var INITIAL_STATE: NodePath

export(Dictionary) var states: Dictionary = {}
export(Array, String) var pushed_states: Array = []

var states_stack: Array = []
var state: State

func _ready() -> void:
	for state in get_children():
		state.connect("finished", self, "_change_state")

"""
Initialise la machine à états avec un état initial
"""
func init() -> void:
	states_stack.push_front(get_node(INITIAL_STATE))
	state = states_stack[0]
	state._enter()

func update(delta: float) -> void:
	state._update(delta)

func _on_animation_finished(animation_name: String) -> void:
	state._on_animation_finished(animation_name)

"""
Change l'état actuel de la machine état
Utiliser cette méthode en passant l'état '_' en paramètre dépile l'état actuel pour revenir à l'état précédent 
"""
func _change_state(state_name: String, parameters: Dictionary) -> void:
	state._exit()
	
	if state_name in pushed_states:
		states_stack.push_front(get_node(states[state_name]))
	if state_name == "_":
		states_stack.pop_front()
	else:
		states_stack[0] = get_node(states[state_name])
	
	state = states_stack[0]
	emit_signal("state_changed", state)
	
	if state_name != "_":
		state._enter(parameters)