extends RefCounted
class_name Transcript

var transcript: Array[TranscriptEntry] = []
var TGameState = load("res://Scripts/game_state.gd").new()
#var game_state: GameState  # Assume GameState is another class you've defined to track state

func _ready():
	print("In the questionable _ready of transcript.gd")
	# Initialize game state here
	#TGameState = GameState.new()
	#
	## Example series of actions
	#perform_action(Action.ActionType.ADD_MANA, {"player_id": 1, "amount": 1}, {"mana_change": 1})
	#perform_action(Action.ActionType.SUBTRACT_LIFE, {"player_id": 2, "amount": 3}, {"life_change": -3})
	#perform_action(Action.ActionType.SUMMON_CREATURE, {"player_id": 1}, {"creature_count_change": 1})
#
## Function to perform an action, apply it to TGameState, and validate
#func perform_action(action_type: Action.ActionType, parameters: Dictionary, expected_changes: Dictionary):
	#var action = Action.new(action_type, parameters, expected_changes)
	#var previous_state = TGameState.duplicate(true)  # Make a copy of the current state
#
	## Update the game state based on the action type
	#update_game_state(action)
	#
	## Validate and log to transcript
	#if action.validate_outcomes(previous_state, TGameState):
		#print("Action validated:", action.type)
		#transcript.append(TranscriptEntry.new(action, TGameState.duplicate(true)))  # Append to transcript
	#else:
		#print("Validation failed for action:", action.type)
		## Handle failure (e.g., rollback or log an error)
#
## Function to update the game state based on an action
#func update_game_state(action: Action):
	#match action.type:
		#Action.ActionType.ADD_MANA:
			#add_mana(action.parameters["player_id"], action.parameters["amount"])
		#Action.ActionType.SUBTRACT_LIFE:
			#subtract_life(action.parameters["player_id"], action.parameters["amount"])
		#Action.ActionType.SUMMON_CREATURE:
			#summon_creature(action.parameters["player_id"])
