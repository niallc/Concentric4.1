extends Node2D
class_name Card

# Card Properties
var card_name: String = ""
var image_name: String = ""
var strength: int = 0
var max_hp: int = 0
var cost: int = 0
var tags: Array = []
var etfEffectName: String = ""

# UI Elements
@onready var control: Control = $Control
@onready var image_rect: TextureRect = $Control/TextureRect
@onready var name_label: Label = $Control/NameLabel
@onready var strength_label: Label = $Control/StrengthLabel
@onready var max_hp_label: Label = $Control/MaxHPLabel
@onready var cost_label: Label = $Control/CostLabel

#onready var control: Control = $Control
#onready var image_rect: TextureRect = $Control/TextureRect if has_node("Control/TextureRect") else null
#onready var name_label: Label = $Control/NameLabel if has_node("Control/NameLabel") else null
#onready var strength_label: Label = $Control/StrengthLabel if has_node("Control/StrengthLabel") else null
#onready var max_hp_label: Label = $Control/MaxHPLabel if has_node("Control/MaxHPLabel") else null
#onready var cost_label: Label = $Control/CostLabel if has_node("Control/CostLabel") else null

func _ready():
#	print("Scene Tree:")
#	print_tree()
#	print("\nNode name:", name)
#	print("Children of this node:", get_children())
#	print("Children of Control:", $Control.get_children() if has_node("Control") else "No Control node")
#	print("Control found:", has_node("Control"))
#	print("NameLabel found:", has_node("Control/NameLabel"))
#	print("StrengthLabel found:", has_node("Control/StrengthLabel"))
#	print("MaxHPLabel found:", has_node("Control/MaxHPLabel"))
#	print("CostLabel found:", has_node("Control/CostLabel"))
#	print("TextureRect found:", has_node("Control/TextureRect"))
	pass
	
func initialize(data: Dictionary) -> void:
	print("Initialize called with data:", data)

	card_name = data.get("card_name", "")
	image_name = data.get("image_name", "")
	print("image_name = ", image_name)
	strength = data.get("strength", 0)
	max_hp = data.get("max_hp", 0)
	cost = data.get("cost", 0)
	tags = data.get("tags", [])
	etfEffectName = data.get("etfEffectName", "")
	
	call_deferred("update_visual_elements")


func update_visual_elements() -> void:
#	print("update_visual_elements called")
#	print("name_label:", name_label)
#	print("strength_label:", strength_label)
#	print("max_hp_label:", max_hp_label)
#	print("cost_label:", cost_label)
#	print("image_rect:", image_rect)
	
	if name_label:
		name_label.text = card_name
	else:
		print("name_label is null, card_name =", card_name)
	
	if strength_label:
		strength_label.text = str(strength)
	else:
		print("strength_label is null, strength = ", strength)
	
	if max_hp_label:
		max_hp_label.text = str(max_hp)
	else:
		print("max_hp_label is null, max_hp = ", max_hp)
	
	if cost_label:
		cost_label.text = str(cost)
	else:
		print("cost_label is null, cost = ", cost)
	
	var image = load(image_name)
	if image and image_rect:
		image_rect.texture = image
	else:
		print("Failed to set image. image =", image, ", image_rect =", image_rect, ", image_name =", image_name)

# Print card info for debugging
func print_info() -> void:
	print(
		"Card Name = ", card_name,
		", Image Name = ", image_name,
		", Strength = ", strength,
		", max_hp = ", max_hp,
		", cost = ", cost,
		", tags = ", tags,
		", etfEffectName = ", etfEffectName
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
