# GameState.gd
extends RefCounted
class_name GameState

var turn: int
var p1_life: int
var p1_mana: int
var p2_life: int
var p2_mana: int

func _init(turn_value: int = 0, p1_life_value: int = 20, p1_mana_value: int = 0, p2_life_value: int = 20, p2_mana_value: int = 0) -> void:
	turn = turn_value
	p1_life = p1_life_value
	p1_mana = p1_mana_value
	p2_life = p2_life_value
	p2_mana = p2_mana_value

# Deep copy function
func duplicate() -> GameState:
	var new_state = GameState.new()
	new_state.turn = self.turn
	new_state.p1_life = self.p1_life
	new_state.p1_mana = self.p1_mana
	new_state.p2_life = self.p2_life
	new_state.p2_mana = self.p2_mana
	return new_state

func printGameState() -> void:
	print("turn: ", turn)
	print("p1_life: ", p1_life)
	print("p1_mana: ", p1_mana)
	print("p2_life: ", p2_life)
	print("p2_mana: ", p2_mana)
