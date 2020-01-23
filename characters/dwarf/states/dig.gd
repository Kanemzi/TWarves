extends State

var vein: Vein

func physics_process(delta: float) -> void:
	pass

func enter(params := {}) -> void:
	var vein_index: int = clamp(params.spot, 1, 3) - 1 
	var veins = get_tree().get_nodes_in_group("vein")
	vein = veins[vein_index]
	if vein == null :
		#TODO find nearest vein
		pass
	var offset = rand_range(-vein.mining_distance, vein.mining_distance)
	owner.target(vein.position + Vector2(offset, 0))
	owner.connect("target_reached", self, "_on_Dwarf_target_reached")
	owner.animator.play("run")

func exit() -> void:
	owner.disconnect("target_reached", self, "_on_Dwarf_target_reached")
	
func _on_Dwarf_target_reached() -> void:
	owner.animator.play("dig")
	owner.sprite.set_direction(vein.position.x - owner.position.x)
		