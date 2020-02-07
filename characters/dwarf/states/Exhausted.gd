extends DwarfLockingState
class_name DwarfExhaustedState
# Etat dans lequel le nain reprend son souffle et ne peut pas se déplacer

func enter(params := {}) -> void:
	.enter(params)
	dwarf.animator.play("exhausted")
	dwarf.animator.connect("animation_finished", self, "_on_Dwarf_animation_finished")


func exit() -> void:
	dwarf.animator.disconnect("animation_finished", self, "_on_Dwarf_animation_finished")
	.exit()


# Exécuté lorsque l'animation d'épuisement est terminée
func _on_Dwarf_animation_finished(anim_name: String) -> void:
	unlock()
