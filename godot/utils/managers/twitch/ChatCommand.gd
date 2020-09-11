extends Node
class_name ChatCommand
# Interface de base d'une commande dans le chat

var _game: Game
var _chat: ChatInterface
var _players: PlayersManager

export(int) var max_args := -1
export(int) var min_args := 0
export(Gift.PermissionFlag) var permission_level := Gift.PermissionFlag.EVERYONE
export(Gift.WhereFlag) var where := Gift.WhereFlag.CHAT

func _ready() -> void:
	yield(owner, "ready")
	_game = owner as Game
	_chat = _game.chat_interface
	_players = _game.players_manager
	_on_ready()

func _on_ready() -> void:
	pass


func prepare(cmd: CommandInfo, args: PoolStringArray) -> void:
	_action(cmd, args)


func _action(cmd: CommandInfo, args: PoolStringArray) -> void:
	pass
