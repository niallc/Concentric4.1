# status_bar.gd
extends Node2D
class_name StatusBar

@onready var segments: Array[ColorRect] = []
const SEGMENT_WIDTH = 20
const SEGMENT_HEIGHT = 40
const SEGMENT_SPACING = 2
const CORNER_RADIUS = 5

var empty_color: Color
var full_color: Color
var gradient: Gradient
var bar_type: StatusBarZone.BarType

func setup(type: StatusBarZone.BarType) -> void:
	bar_type = type
	setup_colors()
	create_segments()


func setup_colors() -> void:
	gradient = Gradient.new()
	if bar_type == StatusBarZone.BarType.LIFE:
		empty_color = Color(0.2, 0.0, 0.0, 1.0)  # Dark red
		full_color = Color(1.0, 0.0, 0.0, 1.0)   # Bright red
	else:
		empty_color = Color(0.0, 0.0, 0.2, 1.0)  # Dark blue
		full_color = Color(0.0, 0.0, 1.0, 1.0)   # Bright blue
	
	gradient.add_point(0.0, empty_color)
	gradient.add_point(1.0, full_color)

func create_segments() -> void:
	for i in range(20):
		var segment = ColorRect.new()
		segment.size = Vector2(SEGMENT_WIDTH, SEGMENT_HEIGHT)
		segment.position.x = i * (SEGMENT_WIDTH + SEGMENT_SPACING)
		
		# Add shader for rounded corners and gradient
		var shader = load("res://shaders/segment_shader.gdshader")
		var material = ShaderMaterial.new()
		material.shader = shader
		material.set_shader_parameter("corner_radius", CORNER_RADIUS)
		segment.material = material
		
		segments.append(segment)
		add_child(segment)

func update_value(current: int, maximum: int = 20) -> void:
	for i in range(segments.size()):
		var segment = segments[i]
		if i < current:
			segment.color = gradient.sample(float(i) / maximum)
		else:
			segment.color = empty_color
