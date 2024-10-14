extends Node2D

# Setup variables needed to read and parse the card data JSON file
const cardsJsonFilepath = "res://Data/cards.json"
var cardsJsonFile = FileAccess.open(cardsJsonFilepath, FileAccess.READ)
var cardsJsonString = ""
var cardsJson = JSON.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cardsJsonFile.store_string(cardsJsonString)
	var error = cardsJsonString.parse(cardsJson.error())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
