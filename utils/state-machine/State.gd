"""
Interface de base d'un état générique
"""
extends Node

class_name State

signal finished(next_state_name, parameters)

func _enter(parameters: Dictionary = {}) -> void:
	return

func _exit() -> void:
	return

func _update(delta: float) -> void:
	return

func _on_animation_finished(animation_name: String) -> void:
	return
