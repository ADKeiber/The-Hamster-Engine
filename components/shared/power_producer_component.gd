extends Node2D
class_name PowerProducerComponent

@export var interactable : InteractableComponent
@export var power : int 
var original_speed

func _ready() -> void:
	interactable.on.connect(produce_power)
	original_speed = interactable.hamster.stats.speed
	interactable.hamster.stats_component.stat_change.connect(stat_change)
	interactable.off.connect(stop_power)

func produce_power() -> void:
	Global.power_produced += power * interactable.hamster.stats.speed

func stop_power() -> void:
	Global.power_produced -= power * interactable.hamster.stats.speed

func stat_change() -> void:
	Global.power_produced -= power * original_speed
	Global.power_produced += power * interactable.hamster.stats.speed
