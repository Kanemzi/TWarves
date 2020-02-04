extends DwarfState
# Super-Etat dans lequel le joueur ne peut pas contrôler le nain
# Toute commande envoyée au nain sera stackée pour être exécutée à la fin de cet état

export(String) var default_next_state := "Move/Dig"

func _ready() -> void:
	for node in get_children():
		node.add_to_group("locking_state")


func exit() -> void:
	pass
