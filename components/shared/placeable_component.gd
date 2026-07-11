class_name PlaceableComponent
extends Node2D

@export var area : Area2D
@export var draggable: DraggableComponent #Placeables required a draggable component... For now... If we decide to have it click to place this won't be needed
@export var footprint: FootprintComponent #Required to know how big something that is placeable is

var grid: GridManager
var placed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid = get_tree().get_first_node_in_group("GridManager")
	draggable.drag_started.connect(_on_drag_started)
	draggable.drag_updated.connect(_on_drag_updated)
	draggable.drag_ended.connect(_on_drag_ended)

func _on_drag_started() -> void:
	grid.register(self)

func _on_drag_updated() -> void:
	if not placed:
		grid.update_hover(get_global_mouse_position())

func _on_drag_ended() -> void:
	var valid_placement = grid.is_valid_placement()
	if valid_placement:
		placed = true
		draggable.draggable = false
	else:
		placed = false
		draggable.failed_to_drop()
	grid.unregister()
