extends DwarfState
class_name DwarfPickState
# Etat dans lequel le nain cherche et ramasse des pépites au sol

var nugget: GoldenNugget

func physics_process(delta: float) -> void:
	_parent.move_to_target(delta)


func enter(params := {}) -> void:
	_parent.connect("target_reached", self, "_on_Dwarf_target_reached")
	dwarf.connect("bend_down", self, "_on_Dwarf_bend_down")
	dwarf.animator.connect("animation_finished", self, "_on_Dwarf_animation_finished")
	_target_nearest_nugget()


func exit() -> void:
	_parent.disconnect("target_reached", self, "_on_Dwarf_target_reached")
	dwarf.disconnect("bend_down", self, "_on_Dwarf_bend_down")
	dwarf.animator.disconnect("animation_finished", self, "_on_Dwarf_animation_finished")
	if nugget != null:
		nugget.disconnect("tree_exited", self, "_target_nearest_nugget")


# Retourne l'ensemble des pépites sur la map
func _get_nuggets() -> Array:
	return get_tree().get_nodes_in_group("golden_nugget")


# Retourne la pépite la plus proche du nain
func _find_nearest_nugget() -> GoldenNugget:
	var nuggets := _get_nuggets()
	if nuggets.size() == 0:
		return null
	
	var nearest : GoldenNugget = null
	var distance := 0
	for n in nuggets:
		if not (n as GoldenNugget).safe_to_pick:
			continue
		var d := dwarf.position.distance_to((n as GoldenNugget).position)
		if  d < distance or nearest == null:
			nearest = n as GoldenNugget
			distance = d
	return nearest


# Ordonne au nain de se déplacer jusqu'à la pépite la plus proche
func _target_nearest_nugget() -> void:
	nugget = _find_nearest_nugget()
	if nugget == null:
		dwarf.state_machine.transition_to("Move/Dig")
		return
	
	# si la pépite est prise avant, on veut chercher une nouvelle pépite
	nugget.connect("tree_exited", self, "_target_nearest_nugget", [], CONNECT_ONESHOT)
	_parent.target(nugget.position)
	
	dwarf.sprite.set_direction(nugget.position.x - dwarf.position.x)
	dwarf.animator.play("run")


# S'exécute lorsque le nain a atteint la pépite qu'il veut prendre
func _on_Dwarf_target_reached() -> void:
	dwarf.animator.play("bend-down")


# S'exécute lorsque le nain est baissé pour attraper la pépite
func _on_Dwarf_bend_down() -> void:
	dwarf.give_nuggets(1)
	nugget.disconnect("tree_exited", self, "_target_nearest_nugget")
	nugget.queue_free()


# S'exécute lorsque le nain se relève après avoir attrapé la pépite
func _on_Dwarf_animation_finished(anim_name: String) -> void:
	if anim_name == "bend-down":
		_target_nearest_nugget()
