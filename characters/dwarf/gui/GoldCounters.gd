extends Node2D
class_name GUIGoldCounters

const GoldCounterScene = preload("res://characters/dwarf/gui/GoldCounter.tscn")

# Ajoute un compteur de pépites pour le nain passé en paramètre
func add_gold_counter_for(dwarf: Dwarf) -> void:
	var counter := GoldCounterScene.instance()
	dwarf.connect("moved", counter, "_on_Dwarf_moved")
	dwarf.connect("caves_exited", counter, "_on_Dwarf_caves_exited")
	dwarf.connect("nuggets_got", counter, "_on_Dwarf_nuggets_got")
	add_child(counter)
	counter.update_position(dwarf.position)