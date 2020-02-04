extends DwarfState
class_name DwarfPunchState
# Etat dans lequel le nain attaque un autre nain dans la mine

# TODO :
# x En entrant dans cet état, le nain trouve la référence vers le nain à cibler
# x Si le nom est incorrect, le nain le plus proche?/riche? est attaqué
# x Le nain attend la disparition de son icone d'action pour commencer à attaquer
# x Le nain commence à se déplacer vers sa cible.
# 	- Particules de poussière
#	- Icone de "Warning" clignote au dessus de la cible
#		- Shader de glow pour l'icone
# x Une fois assez proche de la cible, le nain s'arrête et frappe
#	x (Area2D de proximité pour la détection de la cible)
#	- Si la cible entre en contact avec la hitbox, il entre en état de stun
#	x Si la cible entre en contact avec la hitbox, elle droppe des pépites
#	- Définition du nombre de pépites droppées en fonction de la richesse et de la force
# x Pour attaquer, le nain se déplace au max jusqu'à la cible + une distance définie
# 	- Si la distance max est atteinte le nain entre en état de fatigue et arrête d'attaquer

# Points bonus :
# - Si deux nains s'attaquent entre eux, il devraient tous les deux être stun
# x En frappant le nain, les pépites sont droppées en respectant le sens du coup
# - Système de force définissant la durée du stun de la cible et la quantité de pépites droppées

export(float) var chase_speed := 48.0
export(int) var min_chase_position := 22
export(int) var max_chase_position := 200
export(float) var max_chase_distance := 200.0

var target : WeakRef

onready var attack_delay := $AttackDelay as Timer

func physics_process(delta: float) -> void:
	_parent.move_to_target(delta)


func enter(params := {}) -> void:
	if not "target" in params:
		dwarf.state_machine.transition_to("Move/Dig")
	else:
		target = weakref(params.target)
		print(target.get_ref().display_name + " : " + str(target.get_ref().golden_nuggets))
	dwarf.animator.play("idle")
	attack_delay.start()
	yield(attack_delay, "timeout")
	
	if _is_colliding_target():
		_punch_target()
	else :
		var chase_point := _get_max_chase_point(dwarf.position, target.get_ref().position)
		_parent.target(chase_point, chase_speed)
		_parent.connect("target_reached", self, "_on_Dwarf_target_reached")
		dwarf.connect("dwarf_touched", self, "_on_Dwarf_dwarf_touched")

		dwarf.animator.play("run")
	
	dwarf.sprite.set_direction(target.get_ref().position.x - dwarf.position.x)
	dwarf.connect("punched", self, "_on_Dwarf_punched")
	dwarf.animator.connect("animation_finished", self, "_on_Dwarf_animation_finished")


func exit() -> void:
	_parent.disconnect("target_reached", self, "_on_Dwarf_target_reached")
	dwarf.disconnect("dwarf_touched", self, "_on_Dwarf_dwarf_touched")
	dwarf.disconnect("punched", self, "_on_Dwarf_punched")
	dwarf.animator.disconnect("animation_finished", self, "_on_Dwarf_animation_finished")


# S'exécute lorsque le nain a atteint le filon qu'il doit exploiter
func _on_Dwarf_target_reached() -> void:
	dwarf.animator.play("idle")


func _on_Dwarf_dwarf_touched(other : Dwarf) -> void:
	if other != target.get_ref():
		return
	_punch_target()



# S'exécute lorsque coup du nain atteint sa cible
func _on_Dwarf_punched() -> void:
	var direction = Vector2(dwarf.sprite.direction, 0)
	target.get_ref().drop_nuggets(5, direction)



# S'exécute lorsque le nain a terminé son attaque
func _on_Dwarf_animation_finished(anim_name: String) -> void:
	if anim_name == "punch":
		dwarf.state_machine.transition_to("Move/Pick")


# Retourne la position jusqu'à laquelle le nain peut poursuivre sa cible
func _get_max_chase_point(pos : Vector2, target_pos: Vector2) -> Vector2:
	var chase_point = Vector2(target_pos.x, target_pos.y)
	chase_point.x += sign(target_pos.x - pos.x) * max_chase_distance
	chase_point.x = clamp(chase_point.x, min_chase_position, max_chase_position)
	return chase_point


# Retourne true si le nain est actuellement en contact avec sa cible
func _is_colliding_target() -> bool:
	var colliding_dwarfs = (dwarf.get_node("Punchbox") as Area2D).get_overlapping_bodies()
	return target.get_ref() in colliding_dwarfs


# Donne un coup au nain pris pour cible
func _punch_target() -> void:
	_parent.forget_target()
	dwarf.animator.play("punch")
