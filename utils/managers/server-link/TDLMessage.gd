class_name TDLMessage
# Représente un message échangé avec le serveur de leaderboard/custom distant

enum Type {
  UNDEFINED = -1

  # Messages serveur
  PLAYER_INFORMATION= 0

  # Messages client
  REQUEST_PLAYER = 10
  SAVE_PLAYER_DATA = 11
}

enum Status {
  ERROR = -1
  NOT_SENT = 0
  SENT = 1
}

var _type : int
var _message : Dictionary
var _status : int

func _init(type := Type.UNDEFINED, message := {}) -> void:
  _message = message
  _type = type
  _status = Status.NOT_SENT
  

# Retourne un string json correspondant au message
func build_message() -> String:
  return to_json({
	type = _type,
	message = _message
  })


# Envoie le message au serveur. Retourne l'état du message
func send() -> int:
  var m = build_message()
  var error : int = TDLClient.send_message(m)
  _status = Status.SENT if error == 0 else Status.ERROR
  return _status
