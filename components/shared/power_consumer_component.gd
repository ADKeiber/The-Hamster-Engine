extends Node2D


@export var interactable : InteractableComponent
@export var placeable : PlaceableComponent
var original_speed
@export var min_power_increase = 0
@export var on_min_power_increase = 0


func _ready() -> void:
	interactable.on.connect(on_conusumption)
	interactable.off.connect(base_consumption)
	placeable.sig_placed.connect(placed)
	
func placed() -> void:
	Power.min_power += min_power_increase

func base_consumption() -> void:
	Power.min_power -= on_min_power_increase
	
func on_conusumption() -> void:
	Power.min_power += on_min_power_increase
