extends State
class_name DwarfState

var dwarf: Dwarf

func _ready() -> void:
	yield(owner, "ready")
	dwarf = owner as Dwarf
