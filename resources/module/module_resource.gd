extends Resource
class_name ModuleResource

@export var building_name : String
@export_multiline("Description") var description : String
@export var footprint : Footprint 

@export_group("Sprites")
@export var background_sprite_frames : SpriteFrames
@export var foreground_sprite_frames : SpriteFrames

@export_group("Interactable")
@export var interactable_on : bool

@export_group("Power Producer")
@export var power_producer_on : bool
@export var power : int

@export_group("Power Consumer")
@export var power_consumer_on : bool
@export var min_power_increase : int
@export var on_min_power_increase : int




func attach() -> void:
	pass
