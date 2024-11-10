extends Resource

class_name CardZones

enum ZoneId { P1LIFE,
			  P1MANA,
			  P1L1, P1L2, P1L3,
			  P2L1, P2L2, P2L3 }

const LANE_SCALE_X = 0.3
const LANE_SCALE_Y = 0.3

const P1_LIFE_HEIGHT = 200
const P1_LIFE_WIDTH  = 400
const P1_MANA_HEIGHT = 300
const P1_MANA_WIDTH  = P1_LIFE_WIDTH

const P1_LANE_HEIGHT = 400
const P2_LANE_HEIGHT = 1100
const LANE1_WIDTH = 600
const LANE2_WIDTH = 1200
const LANE3_WIDTH = 1800

const ZONE_LOCATIONS = {
	ZoneId.P1LIFE: Vector2(P1_LIFE_WIDTH, P1_LIFE_HEIGHT),
	ZoneId.P1MANA: Vector2(P1_MANA_WIDTH, P1_MANA_HEIGHT),

	ZoneId.P1L1: Vector2(LANE1_WIDTH, P1_LANE_HEIGHT),
	ZoneId.P1L2: Vector2(LANE2_WIDTH, P1_LANE_HEIGHT),
	ZoneId.P1L3: Vector2(LANE3_WIDTH, P1_LANE_HEIGHT),

	ZoneId.P2L1: Vector2(LANE1_WIDTH, P2_LANE_HEIGHT),
	ZoneId.P2L2: Vector2(LANE2_WIDTH, P2_LANE_HEIGHT),
	ZoneId.P2L3: Vector2(LANE3_WIDTH, P2_LANE_HEIGHT)
}

var zones: Array[CardZone] = []

func _init():
	print("In CardZones init")
	initialize_zones()

# Function to initialize zones
func initialize_zones():
	zones = [CardZone.new(), #P1 Life
			 CardZone.new(), #P1 Mana
			 CardZone.new(), CardZone.new(), CardZone.new(),
			 CardZone.new(), CardZone.new(), CardZone.new()]
	for i in ZoneId.values():
		zones[i].zonePos = ZONE_LOCATIONS[i]
		zones[i].zoneScale = Vector2(LANE_SCALE_X, LANE_SCALE_Y)
		#print("Initialized zone", i, "at location", zones[i].zonePos)

# Getter for zones
func get_zone(zone_id: int) -> CardZone:
	return zones[zone_id]
