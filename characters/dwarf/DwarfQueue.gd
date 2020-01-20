extends Node2D

class_name DwarfQueue

var places := []
var start_place : Position2D
onready var waiting := $Waiting

func _ready():
	places = $Places.get_children()
	start_place = places.back()
