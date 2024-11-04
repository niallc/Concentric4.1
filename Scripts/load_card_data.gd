extends Node2D
class_name CardLoader

const CardScene = preload("res://card.tscn")

# Setup variables needed to read and parse the card data JSON file
const CARDS_JSON_FILEPATH = "res://Data/cards.json"

var cardsJsonString = ""
var cardsJsonStringAlt = ""
var cardsJson = JSON.new()

# Function to instantiate cards from JSON data
func instantiate_cards_from_json() -> Array:
	var card_data_dict = load_cards_from_json(CARDS_JSON_FILEPATH)
	var card_instances = []
	
	var all_cards = card_data_dict.cards
	
	for card_data in all_cards:
		var card_instance = CardScene.instantiate()  # Load the entire scene
		card_instance.initialize(card_data)
		add_child(card_instance)
		card_instances.append(card_instance)
	
	return card_instances

# Load and parse JSON data
func load_cards_from_json(file_path: String) -> Dictionary:
	if FileAccess.file_exists(file_path):
		var cardsJsonFile = FileAccess.open(file_path, FileAccess.READ)

		cardsJsonStringAlt = cardsJsonFile.get_as_text()

		var error = cardsJson.parse(cardsJsonStringAlt)
		if error == OK:
			var parsedData = cardsJson.get_data()

			if(parsedData is Dictionary and parsedData.has("cards")):
				print("Seem to have loaded and parsed card-data!")
				return parsedData
			else:
				print("No parsable data found in:\n  ", file_path)
				return {}
		else:
			if error == 43:
				print("Error = 43, ERR_PARSE_ERROR from JSON.parse")
			else:
				print("Some kind of non-parsing error in JSON.parse...")
				print("error = ", error)
			return error

	else:
		print("Could not find file", file_path)
		return {}
			

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("In Scripts/LoadCardData.gd --> _ready")
	var cards = instantiate_cards_from_json()
	#print("Instaniated cards =\n", cards)
	#print("Instaniated cards[0].card_name = ", cards[0].card_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
