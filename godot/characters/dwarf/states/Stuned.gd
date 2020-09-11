extends DwarfLockingState
class_name DwarfStunedState
# Etat dans lequel le nain est étourdi et ne peut pas se déplacer

export(float) var _friction := 0.9
export(float) var _knockback := 80.0
var _velocity : Vector2


func _physics_process(delta: float) -> void:
	dwarf.move_and_slide(_velocity)
	dwarf.emit_signal("moved", dwarf.position)
	_velocity *= _friction


func enter(params := {}) -> void:
	if not "direction" in params:
		params.direction = 1
	.enter(params)
	_velocity = Vector2(_knockback * params.direction, 0)
	dwarf.sprite.set_direction(-params.direction)
	dwarf.animator.play("stun")
	dwarf.animator.connect("animation_finished", self, "_on_Dwarf_animation_finished")


func exit() -> void:
	dwarf.animator.disconnect("animation_finished", self, "_on_Dwarf_animation_finished")
	.exit()


# Exécuté lorsque l'animation de stun est terminée
func _on_Dwarf_animation_finished(anim_name: String) -> void:
	unlock()
