extends Node2D


@onready var interactable_component : InteractableComponent = $InteractableComponent
@onready var power_producer_component : PowerProducerComponent = $PowerProducerComponent
@onready var power_consumer_component : PowerConsumerComponent = $PowerConsumerComponent
@onready var area : Area2D = $Area2D
@onready var draggable_component : DraggableComponent = $DraggableComponent
@onready var placeable_component : PlaceableComponent = $PlaceableComponent
@onready var footprint_component : FootprintComponent = $FootprintComponent
@onready var animation_component : AnimationComponent = $AnimationComponent
@onready var audio_component : AudioComponent = $AudioComponent
