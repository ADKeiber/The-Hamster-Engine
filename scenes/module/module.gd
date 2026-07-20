extends Node2D
class_name Module

@onready var interactable_component : InteractableComponent = $InteractableComponent
@onready var power_producer_component : PowerProducerComponent = $PowerProducerComponent
@onready var power_consumer_component : PowerConsumerComponent = $PowerConsumerComponent
@onready var area : Area2D = $Area2D
@onready var draggable_component : DraggableComponent = $DraggableComponent
@onready var placeable_component : PlaceableComponent = $PlaceableComponent
@onready var footprint_component : FootprintComponent = $FootprintComponent
@onready var background_animation_component : AnimationComponent = $BackgroundAnimationComponent
@onready var foreground_animation_component : AnimationComponent = $ForegroundAnimationComponent
@onready var audio_component : AudioComponent = $AudioComponent

@export var resource : BuildingResource

func _ready() -> void:
	footprint_component.footprint = resource.footprint
	background_animation_component.sprite_frames = resource.background_sprite_frames
	foreground_animation_component.sprite_frames = resource.foreground_sprite_frames
	power_producer_component.power = resource.power
	power_consumer_component.min_power_increase = resource.min_power_increase
	power_consumer_component.on_min_power_increase = resource.on_min_power_increase
	if resource.interactable_on == false:
		interactable_component.process_mode = Node.PROCESS_MODE_DISABLED
	if resource.power_producer_on == false:
		power_producer_component.process_mode = Node.PROCESS_MODE_DISABLED
	if resource.power_consumer_on == false:
		power_consumer_component.process_mode = Node.PROCESS_MODE_DISABLED
