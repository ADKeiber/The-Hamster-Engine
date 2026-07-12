extends Node2D
class_name InteractorComponent

@export var area : Area2D
@export var draggable : DraggableComponent
@export var animation : AnimationComponent
@onready var hamster : Hamster = self.get_parent()
var interactable : InteractableComponent

func _ready() -> void:
	draggable.drag_ended.connect(check_building)
	draggable.drag_started.connect(picked_up)


func check_building(draggable : DraggableComponent) -> void:
	var building : Area2D = null
	var size : Vector2 = Vector2(9999, 9999)
	var overlapped : Array = area.get_overlapping_areas()
	for b_areas in overlapped:
		if b_areas.is_in_group("Building"):
			if b_areas.get_parent().interactable_component.occupied == false:
				var temp = merge_rect2(area, b_areas)
				if temp < size:
					size = temp
					building = b_areas
	if building != null:
		interactable = building.get_parent().interactable_component
		reparent_hamster(interactable)
	if building == null and hamster.get_parent() is InteractableComponent:
		reparent_hamster(hamster.get_parent())


func reparent_hamster(interactable) -> void:
	if not interactable.is_in_group("Cage"):
		hamster.reparent(interactable)
		animation.invisible()
		hamster.global_position = interactable.global_position
		interactable.entered()
	elif interactable.is_in_group("Cage"):
		hamster.reparent(interactable)
		hamster.global_position = Vector2(randf_range(interactable.start_pos.x, interactable.end_pos.x), randf_range(interactable.start_pos.y, interactable.end_pos.y))

func merge_rect2(h_area : Area2D, building_area) -> Vector2:
	var h_shape = h_area.get_node("CollisionShape2D")
	var b_shape = building_area.get_node("CollisionShape2D")
	
	var h_rect = h_shape.shape.get_rect()
	h_rect.position += h_shape.global_position
	
	var b_rect = b_shape.shape.get_rect()
	b_rect.position += b_shape.global_position
	
	var new_rect = h_rect.merge(b_rect)
	var rect_size = new_rect.size
	return rect_size
	
func picked_up(draggable : DraggableComponent) -> void:
	animation.visible()
	if hamster.get_parent() is InteractableComponent:
		hamster.get_parent().exited()
