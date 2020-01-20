extends State

func _enter(parameters: Dictionary = {}) -> void:
	owner.animator.play("idle")
	return

func _exit() -> void:
	return

func _update(delta: float) -> void:
	return
	
func _on_animation_finished(animation_name: String) -> void:
	return
