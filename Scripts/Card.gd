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

func _ready(verbose: int = 0):
	if verbose > 0:
		print("In Scripts/Card.gd --> _ready")
	pass
	
func initialize(data: Dictionary, verbose: int = 0) -> void:

	card_name = data.get("card_name", "")
	image_name = data.get("image_name", "")
	if (verbose > 0):
		print("image_name = ", image_name)
	strength = data.get("strength", 0)
	max_hp = data.get("max_hp", 0)
	cost = data.get("cost", 0)
	tags = data.get("tags", [])
	etfEffectName = data.get("etfEffectName", "")
	
	call_deferred("update_visual_elements")


func update_visual_elements() -> void:
	
	if name_label:
		name_label.text = card_name
	else:
		print(" name_label is null, card_name = ", card_name)
	
	if strength_label:
		strength_label.text = str(strength)
	else:
		print(" strength_label is null, strength = ", strength)
	
	if max_hp_label:
		max_hp_label.text = str(max_hp)
	else:
		print(" max_hp_label is null, max_hp = ", max_hp)
	
	if cost_label:
		cost_label.text = str(cost)
	else:
		print(" cost_label is null, cost = ", cost)
	
	var image = load(image_name)
	if image and image_rect:
		image_rect.texture = image
	else:
		print(" Failed to set image. image =", image,
			  ", image_rect =", image_rect,
			  ", image_name =", image_name)

# Print card info for debugging
func print_info(verbose: int = 0) -> void:
	if (verbose > 0): 
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
func _process(_delta: float) -> void:
	pass
