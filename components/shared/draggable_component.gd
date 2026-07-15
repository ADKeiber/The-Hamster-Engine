class_name DraggableComponent
extends Node2D

signal drag_started
signal drag_updated
signal drag_ended

@export var area : Area2D
@export var snap_back_on_fail: bool = true #If stopping drag doesn't "succeed" then it will snap back if == true
@export var required_area_to_drop: bool = false


#var area: Area2D
var dragging := false
var drag_offset := Vector2.ZERO
var draggable := true
var start_drag_location : Vector2i 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.input_event.connect(_on_area_input_event)
	#drag_ended.connect(check_failed_to_drop)

func _process(_delta):
	if dragging && draggable:
		get_parent().global_position = get_global_mouse_position() + drag_offset
		drag_updated.emit()

func _on_area_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and draggable:
			dragging = true
			start_drag_location = get_parent().global_position
			get_parent().global_position = get_global_mouse_position()
			drag_started.emit()
			drag_offset = global_position - get_global_mouse_position()
			get_parent().scale = Vector2(1.5, 1.5)
			get_parent().set_z_index(15)
			get_viewport().set_input_as_handled()
		else:
			if draggable == true:
				dragging = false
				drag_ended.emit()
				get_parent().scale = Vector2(1, 1)
				get_parent().set_z_index(1)

			if draggable == false:
				return


#returns to pickup position.. Procs if hamster either "fails to be placed" or "fails to interact" something along those lines
func failed_to_drop() -> void:
	if snap_back_on_fail:
		get_parent().global_position = start_drag_location
	draggable = true
