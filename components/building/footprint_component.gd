class_name FootprintComponent
extends Node2D
#Answers "Which grid cells does this object occupy relative to its anchor?"
#Anchor is set to top left and these points are based on that
#this by default is a 2x2 squre... But allows for more interesting shapes
@export var footprint: Footprint

func get_occupied_cells(anchor: Vector2i) -> Array[Vector2i]:
	var cells: Array[Vector2i] = []
	for offset in footprint.occupied_offsets:
		cells.append(anchor + offset)
	return cells
