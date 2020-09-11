extends State
class_name DwarfState
# Classe représentant un état du nain
# Sert principalement à définir le type de l'owner pour l'autocompletion

var dwarf: Dwarf

func _ready() -> void:
	yield(owner, "ready")
	dwarf = owner as Dwarf
