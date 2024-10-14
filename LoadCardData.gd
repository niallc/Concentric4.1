extends Node2D

# Setup variables needed to read and parse the card data JSON file
const CARDS_JSON_FILEPATH = "res://Data/cards.json"
var cardsJsonString = ""
var cardsJson = JSON.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("In card.tscn _ready...")
	if FileAccess.file_exists(CARDS_JSON_FILEPATH):
		var cardsJsonFile = FileAccess.open(CARDS_JSON_FILEPATH, FileAccess.READ)
		cardsJsonFile.store_string(cardsJsonString)
		var error = cardsJson.parse(cardsJsonString)
		if error:
			print("Some kind of error in parse the cards JSON...")
			print("error = ", error)
		print("cardsJsonString = ", cardsJsonString)
	else:
		print("Could not find file", CARDS_JSON_FILEPATH)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
