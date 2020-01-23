extends Node2D
class_name Cave

onready var dwarf_queue : DwarfQueue = $DwarfQueue

func _ready():
	dwarf_queue.dwarf_pool = $Objects/Dwarfs