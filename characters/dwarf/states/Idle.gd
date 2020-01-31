extends DwarfState
class_name DwarfIdleState

func enter(params := {}) -> void:
	dwarf.animator.play("idle")

func exit() -> void:
	pass
