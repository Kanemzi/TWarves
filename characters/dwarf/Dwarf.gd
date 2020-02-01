extends KinematicBody2D
class_name Dwarf
# Classe représentant un nain dans la mine

signal moved(new_position) # le nain vient de se déplacer
signal caves_exited # le nain vient de quitter la mine
signal queue_exited # le nain vient de sortir de la file d'attente
signal pickaxe_used # le nain vient d'utiliser sa pioche
signal nuggets_got(amount) # le nain vient de trouver des pépites
signal nuggets_lost(amount) # le nain vient de perdre des pépites

var display_name: String
var can_action := true # = true quand le nain peut recevoir des ordres du joueur
var golden_nuggets := 0

onready var animator := $AnimationPlayer as AnimationPlayer
onready var state_machine := $StateMachine as StateMachine
onready var sprite := $Sprite as DwarfSprite
onready var exit_timer := $ExitTimer as Timer

func init(display_name: String = "___dummy___") -> void:
	self.display_name = display_name


func _ready() -> void:
	var max_time := float(ConfigManager.get_setting("gameplay", "max_time_in_caves"))
	exit_timer.wait_time = max_time


# Donne un certain nombre de pépites d'or à un joueur
func give_nuggets(amount: int) -> void:
	golden_nuggets += amount
	if amount != 0:
		emit_signal("nuggets_got", amount)


# Le nain lache [amount] pépites d'or au sol
# Si le nain possède moins de [amount] pépites, il lache toutes ses pépites
func drop_nuggets(amount: int) -> void:
	golden_nuggets -= amount
	if amount != 0:
		var overflow := 0
		if golden_nuggets < 0:
			overflow = abs(golden_nuggets)
			golden_nuggets = 0
		emit_signal("nuggets_lost", amount - overflow)
	

# Fonction exécutée lorsque la pioche du nain frappe un filon
func _pickaxe_animation_hit() -> void:
	emit_signal("pickaxe_used")


# Fonction exécutée lorsque le nain a terminé son temps autorisé dans la mine
func _on_ExitTimer_timeout() -> void:
	self.can_action = false
	state_machine.transition_to("Move/Exit")
