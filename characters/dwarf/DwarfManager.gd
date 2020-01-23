extends Node2D

class_name DwarfManager

signal queue_advanced(dwarf)

onready var queue := $Queue
onready var active := $Active

"""
Ajoute un nouveau nain dans la file d'attente
"""
func add_new(dwarf : Dwarf) -> void :
	print("add " + dwarf.player_name)
	queue.waiting.add_child(dwarf)
	dwarf.translate(queue.start_place.position)
	connect("queue_advanced", get_node(dwarf.states.states["queue"]), "_on_queue_advanced")

"""
Libère le prochain nain de la queue pour le rendre actif dans la mine
Retourne le nain libéré
"""
func free_next() -> Dwarf :
	var dwarf = queue.waiting.get_children().front()
	
	# if the queue is empty
	if dwarf == null : return null
	
	queue.waiting.remove_child(dwarf)
	active.add_child(dwarf)
	dwarf.set_owner(active)
	emit_signal("queue_advanced", dwarf)
	disconnect("queue_advanced", get_node(dwarf.states.states["queue"]), "_on_queue_advanced")
	return dwarf