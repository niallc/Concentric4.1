extends Resource
class_name GameLogic

var game_state: GameState 
enum players {p1, p2}

var transcript: Array[TranscriptEntry] = []

func add_mana(player_id: players, amount: int = 1):
	if player_id == players.p1:
		game_state.p1_mana += amount
	elif player_id == players.p2:
		game_state.p2_mana += amount
	else:
		print("ERROR: couldn't determine the player to add mana to.")

func change_life(player_id: players, amount: int):
	if player_id == players.p1:
		game_state.p1_life -= amount
	elif player_id == players.p2:
		game_state.p2_life -= amount
	else:
		print("ERROR: couldn't determine the player to change the life of.")

func summon_creature(_player_id: players):
		print("ERROR: summon_creature not implemented yet.")

func _ready():
	print("**In battle_logic::_ready**")
	#func _init(round_value: int,
			   #p1_life_value: int, p1_mana_value: int,
			   #p2_life_value: int, p2_mana_value: int) -> void:
	
	game_state = GameState.new(
		0,  # Round number
		20, # p1_life_value
		0,  # p1_mana_value
		20, # p2_life_value
		0)  # p2_mana_value
	#print("Post initialization game_state:\n")
	#game_state.printGameState()

	# Example series of actions
	perform_action(Action.ActionType.ADD_MANA, {"player_id": players.p1, "amount": 1}, {"mana_change": 1})
	perform_action(Action.ActionType.SUBTRACT_LIFE, {"player_id": players.p2, "amount": 3}, {"life_change": -3})
	perform_action(Action.ActionType.SUMMON_CREATURE, {"player_id": players.p1}, {"creature_count_change": 1})
	print("post Modification game_state:\n")
	game_state.printGameState()

# Function to perform an action, apply it to game_state, and validate
func perform_action(action_type: Action.ActionType, parameters: Dictionary, expected_changes: Dictionary):
	var action = Action.new(action_type, parameters, expected_changes)
	var previous_state = game_state.duplicate()  # Make a copy of the current state

	# Update the game state based on the action type
	update_game_state(action)

	# Validate and log to transcript
	if action.validate_outcomes(previous_state, game_state):
		print("Action validated:", action.type)
		transcript.append(TranscriptEntry.new(action, game_state.duplicate()))  # Append to transcript
	else:
		print("Validation failed for action:", action.type)
		# Handle failure (e.g., rollback or log an error)

# Function to update the game state based on an action
func update_game_state(action: Action):
	match action.type:
		Action.ActionType.ADD_MANA:
			add_mana(action.parameters["player_id"], action.parameters["amount"])
		Action.ActionType.SUBTRACT_LIFE:
			change_life(action.parameters["player_id"], action.parameters["amount"])
		Action.ActionType.SUMMON_CREATURE:
			summon_creature(action.parameters["player_id"])
