extends DwarfState
class_name DwarfLockingState

var next_state := ""
var next_state_params := {}

func enter(params := {}) -> void:
	next_state = ""
	next_state_params = {}


func exit() -> void:
	pass


# Définit l'état dans lequel le nain devra entrer une fois débloqué
func will_transition_to(next_state : String, next_state_params := {}) -> void:
	self.next_state = next_state
	self.next_state_params = next_state_params


# Débloque le nain de cet état actuel (le nain change d'état selon la commande)
func unlock() -> void:
	if next_state == "":
		next_state = _parent.default_next_state
	dwarf.state_machine.transition_to(next_state, next_state_params)
