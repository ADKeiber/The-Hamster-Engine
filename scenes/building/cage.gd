extends Node2D
class_name Cage

@export var interactable_component : InteractableComponent
@export var condition : Condition
func _ready() -> void:
	interactable_component.condition = condition
