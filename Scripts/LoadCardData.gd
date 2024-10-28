extends Node2D
class_name CardLoader

const CardScene = preload("res://card.tscn")

# Setup variables needed to read and parse the card data JSON file
const CARDS_JSON_FILEPATH = "res://Data/cards.json"
#const CARDS_JSON_FILEPATH = "res://Data/cards_unquoted.json"

var cardsJsonString = ""
var cardsJsonStringAlt = ""
var cardsJson = JSON.new()

# Function to instantiate cards from JSON data
func instantiate_cards_from_json() -> Array:
	var card_data_dict = load_cards_from_json(CARDS_JSON_FILEPATH)
	var card_instances = []
	
	var all_cards = card_data_dict.cards
	#print("\ncard_data_dict.cards = :")
	#print(all_cards)
	#print("\nFirst element of card_data_dict.cards = :")
	#print(all_cards[0])
	
	for card_data in all_cards:
		#print("This card's data = : ", card_data)
		
		var card_instance = CardScene.instantiate()  # Load the entire scene
		#print("Type of card_instance = ", card_instance)
		#print("Scene Tree:")
		#print_tree()
		card_instance.initialize(card_data)
		add_child(card_instance)
		#card_instance.print_info()
		card_instances.append(card_instance)
	
	return card_instances

# Load and parse JSON data
func load_cards_from_json(file_path: String) -> Dictionary:
	if FileAccess.file_exists(file_path):
		var cardsJsonFile = FileAccess.open(file_path, FileAccess.READ)
		#print("Length of file: ", cardsJsonFile.get_length() )
		#cardsJsonFile.store_string(cardsJsonString)
		#print("cardsJsonString = ", cardsJsonString)

		cardsJsonStringAlt = cardsJsonFile.get_as_text()
		# print("cardsJsonStringAlt = ", cardsJsonStringAlt)

		var error = cardsJson.parse(cardsJsonStringAlt)
		if error == OK:
			var parsedData = cardsJson.get_data()
			#print("Type of JSON parsed string: ", typeof(parsedData))
			#print("Attempting to print cardsJson:")
			#print(parsedData)

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
	instantiate_cards_from_json()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
