extends DwarfState
class_name DwarfIdleState
# Etat dans lequel le nain attend sur place

func enter(params := {}) -> void:
	dwarf.animator.play("idle")

func exit() -> void:
	pass
