class_name DistantMessage
# Représente un message échangé avec le serveur de leaderboard/custom distant

enum Type {
	UNDEFINED = -1, # Type de message libre et non défini

	# Messages reçus
	CUSTOM_PURCHASE = 0 # Message d'achat d'un élément de custom par un joueur
	CUSTOM_EQUIP = 1 # Message d'équipement d'un élément de custom par un joueur

	# Messages envoyés
	PLAYER_UPDATE = 10 # Message contenant une mise à jour du joueur
}

var type := test.

func _init() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
