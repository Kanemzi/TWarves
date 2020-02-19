class_name TDLMessage
# Représente un message échangé avec le serveur de leaderboard/custom distant

# Enumère les différents types de messages traités par le protocole
# TDL. Les types sont documentés dans le fichier TDLMessage.js 
enum Type {
  UNDEFINED = -1

  # Messages serveur
  PLAYER_INFORMATION_FOR_JOIN = 0

  # Messages client
  REQUEST_PLAYER_FOR_JOIN = 10
  SAVE_PLAYER_DATA_WHEN_EXIT = 11
}

enum Status {
  ERROR = -1
  NOT_SENT = 0
  SENT = 1
}

var type : int
var message : Dictionary
var status : int

func _init(t := Type.UNDEFINED, m := {}) -> void:
  message = m
  type = t
  status = Status.NOT_SENT
  

# Retourne un string json correspondant au message
func build_message() -> String:
  return to_json({
    type = type,
    message = message
  })


# Envoie le message au serveur. Retourne l'état du message
func send() -> int:
  var m = build_message()
  var error : int = TDLClient.send_message(m)
  status = Status.SENT if error == 0 else Status.ERROR
  return status
