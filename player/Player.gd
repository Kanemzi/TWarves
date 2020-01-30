extends Node
class_name Player

const DwarfScene := preload("res://characters/dwarf/Dwarf.tscn")

var user_id: String
var display_name: String
var dwarf : Dwarf

var golden_nuggets_total: int

func _init(user_id: String, display_name: String) -> void:
	self.name = user_id
	self.user_id = user_id
	self.display_name = display_name
	self.golden_nuggets_total = 0


func _ready() -> void:
	add_to_group("Players")

# Retourne true si le nain du joueur est actuellement dans la mine, false sinon
func is_in_cave() -> bool:
	return dwarf != null


# Crée le nain associé au joueur
# Se charge de lier les events
func create_dwarf() -> Dwarf:
	dwarf = DwarfScene.instance() as Dwarf
	dwarf.init(display_name)
	dwarf.connect("caves_exited", self, "remove_dwarf")
	return dwarf


# Supprime le nain associé au joueur
func remove_dwarf() -> void:
	# save golds to player
	golden_nuggets_total += dwarf.golden_nuggets
	print("total : " + str(golden_nuggets_total))
	dwarf.queue_free()
	dwarf = null

func get_save_data() -> Dictionary:
	return {
		"user_id": user_id,
		"display_name": display_name,
		"golden_nuggets_total": golden_nuggets_total
	}
