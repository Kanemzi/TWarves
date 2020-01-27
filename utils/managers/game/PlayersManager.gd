extends Node
class_name PlayersManager

export(float) var max_time_in_caves := 20.0

#Retourne true si le joueur joueur a déjà joué au jeu
func exists(user_id: String) -> bool :
	return has_node(user_id)

# Ajoute un nouveau joueur au jeu
# Le joueur créé est retourné.
# Si le joueur existait déjà, le joueur existant est retourné
func add(user_id: String, display_name: String) -> Player :
	if not exists(user_id) :
		var new_player := Player.new(user_id, display_name)
		add_child(new_player)
	return get(user_id)


# Retourne un joueur du jeu en fonction de son user id
func get(user_id: String) -> Player :
	return get_node(user_id) as Player