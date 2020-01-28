extends Node2D
class_name GUIDisplayNames

# Ajoute un nouveau pseudo au layer d'ui
func add_display_name_for(dwarf: Dwarf) -> void:
	var label := DisplayNameLabel.new(dwarf.display_name)
	dwarf.connect("moved", label, "_on_Dwarf_moved")
	dwarf.connect("caves_exited", label, "_on_Dwarf_caves_exited")
	add_child(label)