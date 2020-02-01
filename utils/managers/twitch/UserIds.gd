extends Node

export(String) var API_ENDPOINT := ""

var _cache := {}


# Cherche l'userid correspondant au pseudo d'un utilisateur du chat
func find(display_name: String) -> String :
	if not display_name in _cache:
		var http := HTTPRequest.new()
		add_child(http)
		_send_userid_request(http, display_name)
		http.connect("request_completed", self, "_on_request_completed")
		# Quand la requête est terminée, on sait que le nom se trouve à présent dans le cache
		yield(http, "request_completed") 
		http.queue_free()
	
	return str(_cache[display_name])


# Ajoute une requête à la queue des requêtes
func _build_request(display_name : String) -> String:
	var request := API_ENDPOINT + "?login=" + display_name
	return request



# Déclenche la prochaine requête de la queue
func _send_userid_request(http : HTTPRequest, display_name: String) -> void:
	var client_id := ConfigManager.get_setting("credentials", "client_id")
	if client_id == "":
		return

	var headers := ["Client-ID: " + client_id]
	http.request(_build_request(display_name), headers)


func _on_request_completed(result, response_code, headers, body) -> void:
	var json := JSON.parse(body.get_string_from_utf8())
	var user_id := str(json.result.data[0].id)
	var display_name := str(json.result.data[0].login)
	_cache[display_name] = user_id
