extends State

func physics_process(delta: float) -> void:
	_parent.move_to_target(delta)


func enter(params := {}) -> void:
	
	_parent.target(Vector2(-32, 0))
	_parent.connect("target_reached", self, "_on_Dwarf_target_reached")
	
	owner.animator.play("run")
	owner.sprite.set_direction(-1)


func exit() -> void:
	_parent.disconnect("target_reached", self, "_on_Dwarf_target_reached")


func _on_Dwarf_target_reached() -> void:
	owner.emit_signal("caves_exited")
