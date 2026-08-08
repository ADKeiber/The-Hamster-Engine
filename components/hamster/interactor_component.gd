class_name InteractorComponent
extends Node2D


@export var area : Area2D
@export var draggable : DraggableComponent
@export var animation : AnimationComponent
@onready var hamster : Hamster = self.get_parent()
var interactable : InteractableComponent
var cage : CageInteractableComponent


func _ready() -> void:
	draggable.drag_ended.connect(check_building)
	draggable.drag_started.connect(picked_up)
	cage = get_node("/root/Main/Cage/InteractableComponent")


func check_building() -> void:
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
	if building != null and building.get_parent().interactable_component is InteractableComponent:
		interactable = building.get_parent().interactable_component
		reparent_hamster(interactable)
	elif building == null and hamster.get_parent() is InteractableComponent:
		interactable = hamster.get_parent()
		reparent_hamster(interactable)
	else: 
		interactable = cage
		reparent_hamster(interactable)


func reparent_hamster(parent) -> void:
	if not parent.is_in_group("Cage"):
		hamster.reparent(parent)
		animation.invisible()
		hamster.global_position = parent.global_position
		parent.entered(hamster)
		hamster.velocity = Vector2.ZERO
	elif parent.is_in_group("Cage") && cage.cage_hovered == false:
		hamster.reparent(cage)
		hamster.global_position = Vector2(
			randf_range(cage.start_pos.x, cage.end_pos.x),
		 randf_range(cage.start_pos.y, cage.end_pos.y))
		parent.entered(hamster)
		hamster.velocity = Vector2.ZERO
	elif parent.is_in_group("Cage") && cage.cage_hovered == true:
		hamster.reparent(cage)
		hamster.global_position = get_global_mouse_position()
		parent.entered(hamster)
		hamster.velocity = Vector2.ZERO

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
	
func picked_up() -> void:
	if interactable != null:
		interactable.exited(hamster)
	animation.visible()
	draggable.draggable = true
