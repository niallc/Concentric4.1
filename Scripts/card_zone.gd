extends Resource
class_name CardZone

const CardScene = preload("res://card.tscn")

#@export var location: Vector2
#@export var scale: float = 1.0
#@export var card_texture: Texture2D = null  # Initially no texture assigned
var zonePos: Vector2
var zoneScale: Vector2

var card_instance: Card = null
var card_texture: Texture2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# Function to update card texture
func set_card_texture(inputTexture: Texture2D) -> void:
	card_texture = inputTexture
	print("Texture updated for zone at zonePos ", zonePos)
