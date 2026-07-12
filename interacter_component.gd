extends Node2D


@export var area : Area2D
@export var draggable : DraggableComponent


func _ready() -> void:
	draggable.drag_ended.connect(check_building)


func check_building() -> void:
	var overlapped : Array = area.get_overlapping_areas()
	for areas in overlapped:
		if areas.is_in_group("Building"):
			var interactable = areas.get_parent().interactable_component
			if interactable.occuppied == false:
				reparent_hamster(interactable)
				
func reparent_hamster(interactable) -> void:
	
