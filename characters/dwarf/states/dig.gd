extends State

var vein: Vein

func physics_process(delta: float) -> void:
	_parent.move_to_target(delta)


func enter(params := {}) -> void:
	
	var veins = _get_veins()
	
	if not "spot" in params:
		vein = _find_nearest_vein()
	else:
		var index := clamp(params.spot, 1, veins.size()) - 1
		vein = veins[index]
	
	_parent.connect("target_reached", self, "_on_Dwarf_target_reached")
	_parent.target(_find_place_around_vein(vein))

	owner.animator.play("run")
	owner.sprite.set_direction(vein.position.x - owner.position.x)


func exit() -> void:
	_parent.disconnect("target_reached", self, "_on_Dwarf_target_reached")


"""
Retourne l'ensemble des veine de la map
"""
func _get_veins() -> Array:
	return get_tree().get_nodes_in_group("vein")


"""
Retourne un emplacement aléatoire autour de la veine passée en paramètres
"""
func _find_place_around_vein(vein : Vein) -> Vector2:
	var offset = rand_range(vein.mining_distance / 2, vein.mining_distance)
	var side = pow(-1, randi() % 2)
	return vein.position + Vector2(offset * side, 0)


"""
Retourne la veine la plus proche du nain
"""
func _find_nearest_vein() -> Vein:
	var veins = _get_veins()
	var nearest = veins[0]
	var distance = owner.position.distance_to(nearest.position)
	for v in veins:
		var d = owner.position.distance_to(v.position)
		if  d < distance:
			nearest = v
			distance = d
	return nearest


func _on_Dwarf_target_reached() -> void:
	owner.animator.play("dig")
	owner.sprite.set_direction(vein.position.x - owner.position.x)
