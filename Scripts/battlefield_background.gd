# battlefield_background.gd
extends Node2D

var ZonesClass = preload("res://Scripts/battlefield_zones.gd")
var card_slot_shader: Shader
var card_slot_material: ShaderMaterial

func _ready():
	# Load and setup shader
	card_slot_shader = load("res://shaders/card_slot_shader.gdshader")
	card_slot_material = ShaderMaterial.new()
	card_slot_material.shader = card_slot_shader
	setup_card_slots()

func setup_card_slots():
	# Create slot markers for each card position
	for zone_id in ZonesClass.CardZoneId.values():
		var slot_sprite = Sprite2D.new()
		
		# Create a white texture of appropriate size for the slot
		var slot_texture = create_slot_texture()
		slot_sprite.texture = slot_texture
		
		# Position and scale
		slot_sprite.position = ZonesClass.CARD_ZONE_LOCATIONS[zone_id]
		slot_sprite.scale = Vector2(ZonesClass.LANE_SCALE_X, ZonesClass.LANE_SCALE_Y)
		
		# Apply shader material
		var bkg_material = card_slot_material.duplicate()
		bkg_material.set_shader_parameter("border_width", 4.0)
		bkg_material.set_shader_parameter("corner_radius", 120.0)
		bkg_material.set_shader_parameter("border_color", Color(0.8, 0.8, 0.8, 0.3))
		slot_sprite.material = bkg_material
		
		add_child(slot_sprite)

func create_slot_texture() -> ImageTexture:
	# Create a blank white texture for the shader to work with
	var image = Image.create(350, 500, false, Image.FORMAT_RGBA8)
	image.fill(Color(1, 1, 1, 1))
	return ImageTexture.create_from_image(image)
