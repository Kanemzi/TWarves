extends Node2D
class_name Cave

onready var dwarf_queue := $DwarfQueue as DwarfQueue
onready var veins := $Objects/Veins.get_children() as Array
onready var items := $Objects/Items as Node2D
onready var dwarfs := $Objects/Dwarfs as YSort

func _ready():
	dwarf_queue.dwarf_pool = dwarfs
	dwarf_queue.items_pool = items

#	for vein in veins:
#		(vein as Vein).connect("dropped_nugget", items, "spawn_golden_nuggets")
