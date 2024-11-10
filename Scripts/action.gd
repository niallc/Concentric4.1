extends RefCounted
class_name Action

var type: ActionType
var parameters: Dictionary
var expected_changes: Dictionary  # E.g., {"creature_count": 1}
var game_state: GameState

enum ActionType { ADD_MANA, SUBTRACT_LIFE, SUMMON_CREATURE }

func _init(action_type: ActionType,
		   action_description: Dictionary,
		   expected_changes_in: Dictionary):
	type = action_type
	parameters = action_description
	expected_changes = expected_changes_in

func validate_outcomes(previous_state: GameState,
					   new_state: GameState) -> bool:
	# Compare expected outcomes to actual state changes
	var actual_changes = calculate_diff(previous_state, new_state)
	return actual_changes == expected_changes

func calculate_diff(_previous_state: GameState,
					_new_state: GameState) -> Dictionary:
	print("ERROR: calculate_diff has not been implemented yet.")
	return {"creature_count": 1}
