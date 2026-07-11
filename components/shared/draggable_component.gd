class_name DraggableComponent
extends Node2D

signal drag_started
signal drag_updated
signal drag_ended

@export var area : Area2D
@export var snap_back_on_fail: bool = true #If stopping drag doesn't "succeed" then it will snap back if == true

#var area: Area2D
var dragging := false
var drag_offset := Vector2.ZERO
var draggable := true
var start_drag_location : Vector2i 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.input_event.connect(_on_area_input_event)

func _process(_delta):
	if dragging && draggable:
		var previous_position = get_parent().global_position
		get_parent().global_position = get_global_mouse_position() + drag_offset
		var current_position = get_parent().global_position
		drag_updated.emit()

func _on_area_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and draggable:
			dragging = true
			start_drag_location = get_parent().global_position
			get_parent().global_position = get_global_mouse_position()
			drag_started.emit()
			drag_offset = global_position - get_global_mouse_position()
		else:
			dragging = false
			drag_ended.emit()

#returns to pickup position.. Procs if hamster either "fails to be placed" or "fails to interact" something along those lines
func failed_to_drop() -> void:
	if snap_back_on_fail:
		get_parent().global_position = start_drag_location
	draggable = true
