extends Node

class_name PlayersManagerSingleton

var session_players := {}

func _ready():
	pass

func in_session(name: String) -> bool :
	return name in session_players

"""
Ajoute un nouveau joueur à la session
Le joueur créé est retourné.
Si le joueur existait déjà, le joueur existant est retourné
"""
func add(name: String) -> Player :
	if not in_session(name) :
		session_players[name] = Player.new(name)
	return session_players[name]
	
"""
Retourne un joueur de la session en fonction de son nom
"""
func get(name: String) -> Player :
	return session_players[name]