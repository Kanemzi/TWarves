extends KinematicBody2D

class_name Dwarf

const SPEED := 30

# onready var animator: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
onready var animator: AnimationPlayer = $AnimationPlayer
onready var states: StateMachine = $States

var _target
var player_name : String

func _init(_playername : String = "___dummy___") -> void :
	player_name = _playername

func _ready() -> void:
	states.init()

func move_to_point(point : Vector2) -> void :
	_target = point
	position = point

func _process(delta) -> void:
	states.update(delta)
	