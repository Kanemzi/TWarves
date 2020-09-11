extends Node2D
class_name GUIDisplayNames
# Permet de gérer le layer d'ui affichant le pseudo des nains

const DisplayNameLabelScene = preload("DisplayNameLabel.tscn")

# Ajoute un nouveau pseudo au layer d'ui
func add_display_name_for(dwarf: Dwarf) -> void:
	var label := DisplayNameLabelScene.instance() as DisplayNameLabel
	dwarf.connect("moved", label, "_on_Dwarf_moved")
	dwarf.connect("caves_exited", label, "_on_Dwarf_caves_exited")
	add_child(label)
	label.set_display_name(dwarf.display_name)
	label.update_position(dwarf.position)
