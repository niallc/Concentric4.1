extends RefCounted
class_name TranscriptEntry

var action: Action
var resulting_state: GameState

func _init(action_in: Action, state: GameState):
	self.action = action_in
	self.resulting_state = state.duplicate()
