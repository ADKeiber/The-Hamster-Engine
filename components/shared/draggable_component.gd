class_name DraggableComponent
extends Node2D

signal drag_started(draggable: DraggableComponent)
signal drag_updated(draggable: DraggableComponent)
signal drag_ended(draggable: DraggableComponent)

@export var area : Area2D

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
		var previous_position = global_position
		get_parent().global_position = get_global_mouse_position() + drag_offset
		var current_position = global_position
		drag_updated.emit(self)

func _on_area_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and draggable:
			dragging = true
			start_drag_location = get_parent().global_position
			get_parent().global_position = get_global_mouse_position()
			drag_started.emit(self)
			drag_offset = global_position - get_global_mouse_position()
		else:
			dragging = false
			drag_ended.emit(self)
			#draggable = false

#returns to pickup position
func failed_to_drop() -> void:
	get_parent().global_position = start_drag_location
	draggable = true
