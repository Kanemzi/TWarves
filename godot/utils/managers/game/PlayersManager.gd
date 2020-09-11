extends Node
class_name PlayersManager
# Classe permettant de gérer l'ensemble des joueurs

signal player_joined(player) # un joueur vient de rejoindre la partie

export(float) var max_time_in_caves := 20.0

var _join_queue := []

func _ready() -> void:
	TDLClient.connect("message_received", self, "_on_TDLClient_message_received")


# Retourne true si le joueur est actuellement dans la partie
func exists(user_id: String) -> bool:
	return has_node(user_id)


# Retourne true si le joueur attend d'être créé
func is_in_queue(user_id: String) -> bool:
	return user_id in _join_queue


# Ajoute un nouveau joueur au jeu
# Le joueur créé est retourné.
# Si le joueur existait déjà, le joueur existant est retourné
func add(user_id: String, display_name: String) -> void:
	var m : TDLMessage = TDLMessageBuilder.create_request_player_for_join(
		user_id, display_name)

	var _status := m.send()
	if _status == TDLMessage.Status.SENT:
		_join_queue.append(user_id)


# Retourne un joueur du jeu en fonction de son user id
func get(user_id: String) -> Player:
	return get_node(user_id) as Player


func _on_TDLClient_message_received(message: TDLMessage) -> void:
	if message.type != TDLMessage.Type.PLAYER_INFORMATION_FOR_JOIN:
		return

	var user_id = message.message.player.user_id
	var display_name = message.message.player.display_name
	var golden_nuggets = message.message.player.golden_nuggets
	
	var player := Player.new(user_id, display_name)
	player.golden_nuggets_total = golden_nuggets

	add_child(player)
	emit_signal("player_joined", player)
	_join_queue.erase(user_id)

	print("player joined : " + display_name + " | nuggets : " + str(player.golden_nuggets_total))
