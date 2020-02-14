extends DwarfState
class_name DwarfDigState
# Etat dans lequel le nain se déplacer vers un filon et commence à miner

var vein: Vein

func physics_process(delta: float) -> void:
	_parent.move_to_target(delta)


func enter(params := {}) -> void:
	var veins := _get_veins()
	
	if not "spot" in params:
		vein = _find_nearest_vein()
	else:
		var index := int(clamp(int(params.spot), 1, veins.size()) - 1)
		vein = veins[index]
	
	var mining_spot := _find_place_around_vein(vein)
	_parent.target(mining_spot)
	_parent.connect("target_reached", self, "_on_Dwarf_target_reached")

	dwarf.animator.play("run")
	dwarf.sprite.set_direction(mining_spot.x - dwarf.position.x)
	dwarf.connect("pickaxe_used", self, "_on_Dwarf_pickaxe_used")
	dwarf.connect("pickaxe_used", vein, "_on_Dwarf_pickaxe_used")


func exit() -> void:
	_parent.disconnect("target_reached", self, "_on_Dwarf_target_reached")
	dwarf.disconnect("pickaxe_used", self, "_on_Dwarf_pickaxe_used")
	dwarf.disconnect("pickaxe_used", vein, "_on_Dwarf_pickaxe_used")


# Retourne l'ensemble des veine de la map
func _get_veins() -> Array:
	return get_tree().get_nodes_in_group("vein")


# Retourne un emplacement aléatoire autour de la veine passée en paramètres
func _find_place_around_vein(vein: Vein) -> Vector2:
	var offset := rand_range(vein.mining_distance / 2, vein.mining_distance)
	var side := pow(-1, randi() % 2)
	return vein.position + Vector2(round(offset * side), 0)


# Retourne la veine la plus proche du nain
func _find_nearest_vein() -> Vein:
	var veins := _get_veins()
	if veins.size() == 0:
		return null
	
	var nearest := veins[0] as Vein
	var distance := dwarf.position.distance_to(nearest.position)
	for v in veins:
		var d := dwarf.position.distance_to((v as Vein).position)
		if  d < distance:
			nearest = v as Vein
			distance = d
	return nearest


# S'exécute lorsque le nain a atteint le filon qu'il doit exploiter
func _on_Dwarf_target_reached() -> void:
	dwarf.animator.play("dig")
	dwarf.sprite.set_direction(vein.position.x - dwarf.position.x)


# S'exécute lorsque la pioche du nain frappe un filon
func _on_Dwarf_pickaxe_used() -> void:
	var nuggets_amount := vein.get_nugget_amount()
	dwarf.give_nuggets(nuggets_amount)
