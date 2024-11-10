# status_bar_zone.gd
extends Resource
class_name BarZone

enum BarType { LIFE, MANA }

var zonePos: Vector2
var zoneScale: Vector2
var current_value: int = 20
var max_value: int = 20
var bar_type: BarType

var width: float = 200  # Default width
var height: float = 40  # Default height

func _init(type: BarType = BarType.LIFE):
	bar_type = type

func update_value(new_value: int) -> void:
	current_value = clamp(new_value, 0, max_value)
