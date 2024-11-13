extends Resource

class_name CardZones

enum CardZoneId { 
	P1L1, P1L2, P1L3,
	P2L1, P2L2, P2L3,
}
enum BarZoneId {
	P1LIFE,
	P1MANA,
	P2LIFE,
	P2MANA 
}

const LANE_SCALE_X = 0.3
const LANE_SCALE_Y = 0.3

const SEGMENT_BAR_GAP = 50
const P1_LIFE_HEIGHT = 100
const P1_LIFE_WIDTH  = 400
const P1_MANA_HEIGHT = P1_LIFE_HEIGHT + SEGMENT_BAR_GAP
const P1_MANA_WIDTH  = P1_LIFE_WIDTH
const P2_LIFE_HEIGHT = 1300
const P2_LIFE_WIDTH  = P1_LIFE_WIDTH
const P2_MANA_HEIGHT = P2_LIFE_HEIGHT + SEGMENT_BAR_GAP
const P2_MANA_WIDTH  = P1_LIFE_WIDTH

const P1_LANE_HEIGHT = 400
const P2_LANE_HEIGHT = 1060
const LANE1_WIDTH = 600
const LANE2_WIDTH = 1200
const LANE3_WIDTH = 1800

const CARD_ZONE_LOCATIONS = {
	CardZoneId.P1L1: Vector2(LANE1_WIDTH, P1_LANE_HEIGHT),
	CardZoneId.P1L2: Vector2(LANE2_WIDTH, P1_LANE_HEIGHT),
	CardZoneId.P1L3: Vector2(LANE3_WIDTH, P1_LANE_HEIGHT),

	CardZoneId.P2L1: Vector2(LANE1_WIDTH, P2_LANE_HEIGHT),
	CardZoneId.P2L2: Vector2(LANE2_WIDTH, P2_LANE_HEIGHT),
	CardZoneId.P2L3: Vector2(LANE3_WIDTH, P2_LANE_HEIGHT)
}

const BAR_ZONE_LOCATIONS = {
	BarZoneId.P1LIFE: Vector2(P1_LIFE_WIDTH, P1_LIFE_HEIGHT),
	BarZoneId.P1MANA: Vector2(P1_MANA_WIDTH, P1_MANA_HEIGHT),
	BarZoneId.P2LIFE: Vector2(P2_LIFE_WIDTH, P2_LIFE_HEIGHT),
	BarZoneId.P2MANA: Vector2(P2_MANA_WIDTH, P2_MANA_HEIGHT),
}

var bar_zones: Array[BarZone] = []
var card_zones: Array[CardZone] = []

var zones: Dictionary = {"card_zones": card_zones,
						 "bar_zones": bar_zones}

func _init():
	print("In CardZones init")
	initialize_zones()

# Function to initialize zones
func initialize_zones():
	bar_zones = [BarZone.new(), #P1 Life
				 BarZone.new(), #P1 Mana
				 BarZone.new(), #P2 Life
				 BarZone.new()] #P2 Mana
	card_zones = [CardZone.new(), CardZone.new(), CardZone.new(),
				  CardZone.new(), CardZone.new(), CardZone.new()]
	zones.card_zones = card_zones
	zones.bar_zones = bar_zones
	
	for i in CardZoneId.values():
		zones.card_zones[i].zonePos = CARD_ZONE_LOCATIONS[i]
		zones.card_zones[i].zoneScale = Vector2(LANE_SCALE_X, LANE_SCALE_Y)
		#print("Initialized zone", i, "at location", zones[i].zonePos)

	for i in BarZoneId.values():
		zones.bar_zones[i].zonePos = BAR_ZONE_LOCATIONS[i]

# Getter for zones
func get_card_zone(zone_id: int) -> CardZone:
	return zones.card_zones[zone_id]

func get_bar_zone(zone_id: int) -> BarZone:
	return zones.bar_zones[zone_id]
