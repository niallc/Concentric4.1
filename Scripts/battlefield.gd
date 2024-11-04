# Battlefield.gd
extends Node2D

var CardZonesClass = load("res://Scripts/card_zones.gd")
@onready var card_zones_inst = CardZonesClass.new()

func _ready():
	print("In Battlefield _ready")
	card_zones_inst.initialize_zones()  # Ensure zones are initialized

	# Set textures and render zones
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P1L1), 
						 load("res://art/knight.webp"))
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P1L2), 
						 load("res://art/vengefulWarlord.webp"))
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P1L3), 
						 load("res://art/amnesiaMage.webp"))

	# Set textures and render zones
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P2L1), 
						 load("res://art/knight.webp"))
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P2L2), 
						 load("res://art/vengefulWarlord.webp"))
	update_zone_constant(card_zones_inst.get_zone(CardZonesClass.ZoneId.P2L3), 
						 load("res://art/amnesiaMage.webp"))

	render_zones()

func render_zones():
	for i in CardZonesClass.ZoneId.values():
		var visual_node = Sprite2D.new()
		visual_node.position = CardZonesClass.ZONE_LOCATIONS[i]
		var this_scale = card_zones_inst.get_zone(i).zoneScale
		print("typeof(this_scale) = ", typeof(this_scale))
		print("this_scale = " ,this_scale)
		visual_node.scale = Vector2(this_scale[0], this_scale[1])
		visual_node.texture = card_zones_inst.get_zone(i).card_texture
		add_child(visual_node)

func update_zone_constant(zone: CardZone, texture: Texture2D) -> void:
	zone.set_card_texture(texture)
