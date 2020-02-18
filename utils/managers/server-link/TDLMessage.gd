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

var type : int
var message : Dictionary
var status : int

func _init(type := Type.UNDEFINED, message := {}) -> void:
  self.message = message
  self.type = type
  self.status = Status.NOT_SENT
  

# Retourne un string json correspondant au message
func build_message() -> String:
  return to_json({
    type = self.type,
    message = self.message
  })


# Envoie le message au serveur. Retourne l'état du message
func send() -> int:
  var m = build_message()
  var error : int = TDLClient.send_message(m)
  self.status = Status.SENT if error == 0 else Status.ERROR
  return self.status
