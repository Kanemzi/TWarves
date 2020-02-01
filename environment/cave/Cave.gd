extends Node2D
class_name Cave

onready var dwarf_queue := $DwarfQueue as DwarfQueue
onready var veins := $Objects/Veins.get_children() as Array
onready var items := $Objects/Items

func _ready():
	dwarf_queue.dwarf_pool = $Objects/Dwarfs as YSort
	dwarf_queue.items_pool = $Objects/Items as Node2D

	for vein in veins:
		(vein as Vein).connect("dropped_nugget", items, "spawn_golden_nuggets")
