class_name BuildingResource
extends Resource


@export var building_name : String
@export_multiline("Description") var description : String
@export var footprint : Footprint 

@export_group("Sprites")
@export var background_sprite_frames : SpriteFrames
@export var foreground_sprite_frames : SpriteFrames

@export_group("Interactable")
@export var interactable_on : bool
@export var interactale_locked : bool
@export var locked_in_time : float

@export_group("Power Producer")
@export var power_producer_on : bool
@export var power : int

@export_group("Power Consumer")
@export var power_consumer_on : bool
@export var min_power_increase : int
@export var on_min_power_increase : int




func turn_on(hamster : Hamster, cage : CageInteractableComponent) -> void:
	pass

func turn_off(hamster : Hamster, cage : CageInteractableComponent) -> void:
	hamster.interactor.reparent_hamster(cage)
	hamster.interactor.picked_up()
	hamster.interactor.interactable = cage

#func return_hamster(node) -> void:
	##var cage = node.get_node("/root/Main/Cage/InteractableComponent")
	##
