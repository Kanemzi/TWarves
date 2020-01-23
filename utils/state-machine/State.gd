extends Node
class_name State
"""
Interface de base d'un état générique
"""

var _state_machine : Node

func _ready() -> void:
	yield(owner, "ready")
	_state_machine = get_parent()

func unhandled_input(event: InputEvent) -> void:
	pass

func physics_process(delta: float) -> void:
	pass

func enter(params := {}) -> void:
	pass

func exit() -> void:
	pass