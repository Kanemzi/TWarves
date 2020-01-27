extends Node
class_name Player

const DwarfScene := preload("res://characters/dwarf/Dwarf.tscn")

var user_id: String
var display_name: String
var score : int
var dwarf : Dwarf

func _init(user_id: String, display_name: String) -> void:
	self.name = user_id
	self.user_id = user_id
	self.display_name = display_name
	self.score = 0


# Retourne true si le nain du joueur est actuellement dans la mine, false sinon
func is_in_cave() -> bool:
	return dwarf != null


# Crée le nain associé au joueur
# Se charge de lier les events
func create_dwarf() -> Dwarf:
	dwarf = DwarfScene.instance()
	dwarf.init(display_name)
	dwarf.connect("caves_exited", self, "remove_dwarf")
	return dwarf


# Supprime le nain associé au joueur
func remove_dwarf() -> void:
	dwarf.queue_free()
	dwarf = null