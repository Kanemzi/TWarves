extends Node2D
class_name DwarfQueue
# Classe permettant de gérer le fonctionnement de la file d'attente

signal advanced # les nains dans la queue peuvent avancer

export(int) var max_allowed_in_mine := 1

var counter: int # compte le nombre de nains actuellement dans la file
var current_in_mine: int # compte le nombre de nains actuellement dans la mine
var dwarf_pool: YSort
var items_pool: Node2D # lisaison des signaux pour l'apparition des items

onready var places := $Places.get_children()
onready var start_place := places.back() as Position2D

func _ready() -> void:
	current_in_mine = 0
	counter = 0


# Ajoute un nouveau nain dans la file d'attente
func add(dwarf: Dwarf) -> void:
	print("add " + dwarf.display_name)
	dwarf.translate(start_place.position)
	dwarf_pool.add_child(dwarf)
	dwarf.connect("queue_exited", self, "_on_Dwarf_queue_exited")
	dwarf.connect("caves_exited", self, "_on_Dwarf_caves_exited")
	dwarf.state_machine.transition_to("Move/Queue", 
			{"queue": self, "index": counter})
	counter += 1


# S'exécute lorsqu'un nain quitte la file
func _on_Dwarf_queue_exited() -> void:
	counter -= 1
	current_in_mine += 1
	emit_signal("advanced")


# S'exécute lorsqu'un nain quitte la mine
func _on_Dwarf_caves_exited() -> void:
	current_in_mine -= 1
	emit_signal("advanced")
