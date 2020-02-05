extends Node2D
class_name GUIIcons
# Permet de gérer le layer d'ui affichant les icones des nains

const ActionIconScene = preload("ActionIcon.tscn")
const WarningIconScene = preload("WarningIcon.tscn")


# Ajoute une icone d'action pour le nain passé en paramètre
func spawn_action_icon_for(dwarf: Dwarf, type: String) -> void:
	var icon := ActionIconScene.instance() as ActionIcon
	dwarf.connect("moved", icon, "_on_Dwarf_moved")
	dwarf.connect("caves_exited", icon, "_on_Dwarf_caves_exited")
	add_child(icon)
	icon.set_icon(type)
	icon.update_position(dwarf.position)


# Ajoute une icone d'alerte au dessus du nain passé en paramètre
func spawn_alert_icon_for(dwarf: Dwarf) -> void:
	var icon := WarningIconScene.instance() as WarningIcon
	dwarf.connect("moved", icon, "_on_Dwarf_moved")
	dwarf.connect("caves_exited", icon, "_on_Dwarf_caves_exited")
	add_child(icon)
	icon.update_position(dwarf.position)
