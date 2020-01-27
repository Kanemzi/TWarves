extends Node2D
class_name DwarfQueue

onready var places := $Places.get_children()
onready var start_place : Position2D = places.front()

var dwarf_pool : YSort

# Ajoute un nouveau nain dans la file d'attente
func add(dwarf : Dwarf) -> void :
	print("add " + dwarf.display_name)
	dwarf.translate(start_place.position)
	dwarf_pool.add_child(dwarf)