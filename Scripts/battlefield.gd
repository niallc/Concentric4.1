# Battlefield.gd
extends Node2D

var ZonesClass = load("res://Scripts/battlefield_zones.gd")
var CardLoaderBf = load("res://Scripts/load_card_data.gd").new()
var MyGameLogic = load("res://Scripts/battle_logic.gd").new()
@onready var card_zones_inst = ZonesClass.new()

var status_bars: Dictionary = {}
var background: Node2D


func _ready():
	print("In Battlefield _ready")
	background = preload("res://Scripts/battlefield_background.gd").new()
	add_child(background)
	background.z_index = 1  # Higher numbers make the card_slot appearon top of the cards
	
	# Add a debug visual to verify the background node is present
	var debug_rect = ColorRect.new()
	debug_rect.size = Vector2(100, 100)
	debug_rect.position = Vector2(200, 200)
	debug_rect.color = Color(1, 0.5, 0, 0.3)  # Semi-transparent yellow
	background.add_child(debug_rect)
	print("Added debug rectangle to background")

	var all_cards = CardLoaderBf.instantiate_cards_from_json()
	var p1_cards = all_cards.slice(0,3)
	var p2_cards = all_cards.slice(3,6)
	var _test_transcript = MyGameLogic._ready()
	print("length(p1_cards) = ", len(p1_cards))
	print("length(p2_cards) = ", len(p2_cards))
	card_zones_inst.initialize_zones()  # Ensure zones are initialized

	# Set textures and render zones
	update_zone_constant(card_zones_inst.get_card_zone(ZonesClass.CardZoneId.P1L1), 
						 load(p1_cards[0].image_name))
	update_zone_constant(card_zones_inst.get_card_zone(ZonesClass.CardZoneId.P1L2), 
						 load(p1_cards[1].image_name))
	update_zone_constant(card_zones_inst.get_card_zone(ZonesClass.CardZoneId.P1L3), 
						 load(p1_cards[2].image_name))

	# Set textures and render zones
	update_zone_constant(card_zones_inst.get_card_zone(ZonesClass.CardZoneId.P2L1), 
						 load(p2_cards[0].image_name))
	update_zone_constant(card_zones_inst.get_card_zone(ZonesClass.CardZoneId.P2L2), 
						 load(p2_cards[1].image_name))
	update_zone_constant(card_zones_inst.get_card_zone(ZonesClass.CardZoneId.P2L3), 
						 load(p2_cards[2].image_name))

	setup_status_bars()
	render_zones()

func render_zones():
	for i in ZonesClass.CardZoneId.values():
		var visual_node = Sprite2D.new()
		visual_node.position = ZonesClass.CARD_ZONE_LOCATIONS[i]
		var this_scale = card_zones_inst.get_card_zone(i).zoneScale
		visual_node.scale = Vector2(this_scale[0], this_scale[1])
		visual_node.texture = card_zones_inst.get_card_zone(i).card_texture
		
		# Add shader for rounded corners
		var shader = load("res://shaders/card_shader.gdshader")
		var shader_material = ShaderMaterial.new()
		shader_material.shader = shader
		shader_material.set_shader_parameter("corner_radius", 120.0)  # Adjust as needed
		shader_material.set_shader_parameter("edge_softness", 2.0)   # Adjust for sharper/softer edges
		visual_node.material = shader_material
		
		add_child(visual_node)
	
	# Render bar zones
	for i in ZonesClass.BarZoneId.values():
		var zone = card_zones_inst.get_bar_zone(i)
		var status_bar = StatusBar.new()
		status_bar.position = zone.zonePos
		status_bar.setup(zone.bar_type)  # This configures colors and creates segments
		status_bar.update_value(zone.current_value)
		add_child(status_bar)
		status_bars[i] = status_bar  # Store reference



func update_zone_constant(zone: CardZone, texture: Texture2D) -> void:
	zone.set_card_texture(texture)

func setup_status_bars():
	var p1_life_zone = card_zones_inst.get_bar_zone(CardZones.BarZoneId.P1LIFE)
	var p1_mana_zone = card_zones_inst.get_bar_zone(CardZones.BarZoneId.P1MANA)
	var p2_life_zone = card_zones_inst.get_bar_zone(CardZones.BarZoneId.P2LIFE)
	var p2_mana_zone = card_zones_inst.get_bar_zone(CardZones.BarZoneId.P2MANA)
	
	# Initialize the zones with their types
	p1_life_zone.bar_type = BarZone.BarType.LIFE
	p1_mana_zone.bar_type = BarZone.BarType.MANA
	p2_life_zone.bar_type = BarZone.BarType.LIFE
	p2_mana_zone.bar_type = BarZone.BarType.MANA

#func update_bar(zone_id: ZonesClass.BarZoneId, new_value: int):
func update_bar(zone_id, new_value: int):
	var zone = card_zones_inst.get_bar_zone(zone_id)
	zone.update_value(new_value)
	if zone_id in status_bars:
		status_bars[zone_id].update_value(zone.current_value)
