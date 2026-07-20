extends Node2D
class_name PowerProducerComponent

@export var interactable : InteractableComponent
@export var power : int 
var original_speed

func _ready() -> void:
	interactable.on.connect(produce_power)
	interactable.off.connect(stop_power)

func produce_power() -> void:
	original_speed = interactable.hamster.stats.speed
	if interactable.hamster.hamster_stats_component.stat_changed.is_connected(stat_change):
		interactable.hamster.hamster_stats_component.stat_changed.disconnect(stat_change)
	interactable.hamster.hamster_stats_component.stat_changed.connect(stat_change)
	Power.power_produced += power * original_speed

func stop_power() -> void:
	Power.power_produced -= power * original_speed

func stat_change() -> void:
	Power.power_produced -= power * original_speed
	Power.power_produced += power * interactable.hamster.stats.speed
