extends Node2D
class_name GUIGoldCounters
# Permet de gérer le layer d'ui affichant les compteurs
# de pépites d'or des nains

const GoldCounterScene = preload("GoldCounter.tscn")

# Ajoute un compteur de pépites pour le nain passé en paramètre
func add_gold_counter_for(dwarf: Dwarf) -> void:
	var counter := GoldCounterScene.instance()
	dwarf.connect("moved", counter, "_on_Dwarf_moved")
	dwarf.connect("caves_exited", counter, "_on_Dwarf_caves_exited")
	dwarf.connect("nuggets_got", counter, "_on_Dwarf_nuggets_got")
	add_child(counter)
	counter.update_position(dwarf.position)
