# Battlefield.gd
extends Node2D

var ZonesClass = load("res://Scripts/battlefield_zones.gd")
var CardLoaderBf = load("res://Scripts/load_card_data.gd").new()
var MyGameLogic = load("res://Scripts/battle_logic.gd").new()
@onready var card_zones_inst = ZonesClass.new()

func _ready():
	print("In Battlefield _ready")
	
	var all_cards = CardLoaderBf.instantiate_cards_from_json()
	var p1_cards = all_cards.slice(0,3)
	var p2_cards = all_cards.slice(3,6)
	var _test_transcript = MyGameLogic._ready()
	print("length(p1_cards) = ", len(p1_cards))
	print("length(p2_cards) = ", len(p2_cards))
	card_zones_inst.initialize_zones()  # Ensure zones are initialized

	# Set textures and render zones
	print()
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
		add_child(visual_node)
	
	for i in ZonesClass.BarZoneId.values():
		print("OMG, how do I render a bar zone?")


func update_zone_constant(zone: CardZone, texture: Texture2D) -> void:
	zone.set_card_texture(texture)

## Example usage in battlefield.gd
#func create_status_bars():
## Currently the ZONES are created in battlefield_zones.gd, so there's no 
## need to create zones here.
	#var life_zone = StatusBarZone.new(StatusBarZone.BarType.LIFE)
	##life_zone.zonePos = Vector2(P1_LIFE_WIDTH, P1_LIFE_HEIGHT)
	##
	#var mana_zone = StatusBarZone.new(StatusBarZone.BarType.MANA)
	##mana_zone.zonePos = Vector2(P1_MANA_WIDTH, P1_MANA_HEIGHT)
	#
	#var life_bar = StatusBar.new()
	#life_bar.position = life_zone.zonePos
	#add_child(life_bar)
	#
	#var mana_bar = StatusBar.new()
	#mana_bar.position = mana_zone.zonePos
	#add_child(mana_bar)
	#
	## Example updates
	#life_bar.update_value(15) # Set life to 15/20
	#mana_bar.update_value(10) # Set mana to 10/20

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
