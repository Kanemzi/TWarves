extends State

var count = 0

func _enter(parameters: Dictionary = {}) -> void:
	var vein_index: int = clamp(parameters.tier, 1, 3) - 1 
	var vein: Vein = get_tree().get_nodes_in_group("vein")[vein_index]
	owner.position.x = vein.position.x - 12
	owner.animator.play("dig")
	return

func _exit() -> void:
	return

func _update(delta: float) -> void:
	return

func _on_animation_finished(animation_name: String) -> void:
	return
