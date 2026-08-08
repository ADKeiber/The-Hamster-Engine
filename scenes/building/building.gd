extends Node2D
class_name Building

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
@onready var locked_in_bar : TextureProgressBar = $LockedInBarComponent
@onready var locked_in_timer : Timer = $LockedInTimer
@onready var cage = get_node("/root/Main/Cage/InteractableComponent")
@onready var hamster : Hamster
@export var resource : BuildingResource

func _ready() -> void:
	footprint_component.footprint = resource.footprint
	background_animation_component.sprite_frames = resource.background_sprite_frames
	foreground_animation_component.sprite_frames = resource.foreground_sprite_frames
	power_producer_component.power = resource.power
	power_consumer_component.min_power_increase = resource.min_power_increase
	power_consumer_component.on_min_power_increase = resource.on_min_power_increase
	interactable_component.condition = resource.condition

	if resource.interactable_on == false:
		interactable_component.queue_free()
	if resource.interactale_locked == true:
		interactable_component.locked_in = true
	if resource.power_producer_on == false:
		power_producer_component.queue_free()
	if resource.power_consumer_on == false:
		power_consumer_component.queue_free()
		
func _process(delta: float) -> void:
	locked_in_bar.value = locked_in_timer.wait_time - locked_in_timer.time_left

func _on_interactable_component_on() -> void:
	hamster = interactable_component.hamster
	if resource.interactale_locked == true:
		locked_in_timer.wait_time = resource.locked_in_time
		locked_in_bar.max_value = locked_in_timer.wait_time
		locked_in_timer.start()
		locked_in_bar.show()
		locked_in_timer.timeout.connect(locked_in_timeout, CONNECT_ONE_SHOT)
	else: resource.turn_on(hamster, cage)



func _on_interactable_component_off() -> void:
	pass # Replace with function body.

func locked_in_timeout() -> void:
	if hamster != null:
		resource.turn_on(hamster, cage)
		locked_in_bar.hide()
		resource.turn_off(hamster, cage)
	else : locked_in_bar.hide()
