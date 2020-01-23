extends Node
class_name State
"""
Interface de base d'un état générique
"""

var _state_machine := _get_state_machine(self)
var _parent: State = null

func _ready() -> void:
	yield(owner, "ready")
	_parent = get_parent() as State


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(params := {}) -> void:
	pass


func exit() -> void:
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node