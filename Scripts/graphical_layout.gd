extends Node2D
class_name PlayArea

const CardScene = preload("res://card_zone.tscn")
# const CardScene = preload("res://card.tscn")
# 		var card_instance = CardScene.instantiate()  # Load the entire scene

# Constants for layout configuration
const CARD_HEIGHT_PROPORTION := 0.2

# Object to store the objects and associated graphical parameters
# that can appear in the PlayArea
# Though arrays are untyped
var Zones = []

# Retain a reference 
var LocationMap = {
	"P1L1": "empty",
	"P1L2": "empty",
	"P1L3": "empty",
	"P2L1": "empty",
	"P2L2": "empty",
	"P2L3": "empty",
	"P1Discard": [],
	"P2Discard": []
}

var layoutParams = {
	# Using [NAN, NAN] as a kind of user type-hint to explain that
	# these are meant to be Vector2 objects
	"viewport_size": [NAN, NAN],
	"card_size": [NAN, NAN]
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
