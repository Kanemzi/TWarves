extends DwarfState
class_name DwarfExitState
# Etat dans lequel le nain se déplace vers la sortie de la mine

func physics_process(delta: float) -> void:
	_parent.move_to_target(delta)

func enter(params := {}) -> void:
	
	_parent.target(Vector2(-32, 0))
	_parent.connect("target_reached", self, "_on_Dwarf_target_reached")
	
	dwarf.animator.play("run")
	dwarf.sprite.set_direction(-1)


func exit() -> void:
	_parent.disconnect("target_reached", self, "_on_Dwarf_target_reached")


# S'exécute lorsque le nain vient de sortir de la mine
func _on_Dwarf_target_reached() -> void:
	dwarf.emit_signal("caves_exited")
