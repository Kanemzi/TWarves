extends Node2D
class_name GUIActionIcons

const ActionIconScene = preload("res://characters/dwarf/gui/ActionIcon.tscn")

# Ajoute un icon d'action pour le nain passé en paramètre
func spawn_action_icon_for(dwarf: Dwarf, type: String) -> void:
	var icon := ActionIconScene.instance() as ActionIcon
	dwarf.connect("moved", icon, "_on_Dwarf_moved")
	dwarf.connect("caves_exited", icon, "_on_Dwarf_caves_exited")
	add_child(icon)
	icon.set_icon(type)