# Battlefield.gd
extends Node2D

var CardZonesClass = load("res://Scripts/card_zones.gd")
var CardLoaderBf = load("res://Scripts/load_card_data.gd").new()
var MyGameLogic = load("res://Scripts/battle_logic.gd").new()
@onready var card_zones_inst = CardZonesClass.new()

func _ready():
	print("In Battlefield _ready")
	
	var all_cards = CardLoaderBf.instantiate_cards_from_json()
	var _test_transcript = MyGameLogic._ready()
	print("typeof(all_cards) = ", typeof(all_cards))
	card_zones_inst.initialize_zones()  # Ensure zones are initialized

	# Set textures and render zones
	var card1 = all_cards[0]
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P1L1), 
						 load(card1.image_name))
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P1L2), 
						 load(all_cards[1].image_name))
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P1L3), 
						 load(all_cards[2].image_name))

	# Set textures and render zones
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P2L1), 
						 load(all_cards[3].image_name))
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P2L2), 
						 load(all_cards[4].image_name))
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P2L3), 
						 load(all_cards[5].image_name))

	render_zones()

func render_zones():
	for i in CardZonesClass.ZoneId.values():
		var visual_node = Sprite2D.new()
		visual_node.position = CardZonesClass.ZONE_LOCATIONS[i]
		var this_scale = card_zones_inst.get_zone(i).zoneScale
		visual_node.scale = Vector2(this_scale[0], this_scale[1])
		visual_node.texture = card_zones_inst.get_zone(i).card_texture
		add_child(visual_node)

func update_zone_constant(zone: CardZone, texture: Texture2D) -> void:
	zone.set_card_texture(texture)
