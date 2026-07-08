class_name GridManager
extends Node2D

@export var highlight_source_id: int = 0
@export var highlight_atlas_coords: Vector2i = Vector2i.ZERO

@export var tile_map: TileMapLayer
@export var highlight_map: TileMapLayer

var highlighted_cells: Array[Vector2i] = []
var occupied_cells: Array[Vector2i] = []
var registered_node: PlaceableComponent
var drag_offset := Vector2.ZERO

func _ready() -> void:
	highlight_map.clear()

func update_highlight():
	var parent := registered_node.get_parent()
	var shape := registered_node.area.get_child(0).shape as RectangleShape2D
	var extents = shape.size / 2.0
	var top_left = parent.global_position - extents
	var tl = tile_map.local_to_map(tile_map.to_local(top_left))
	var cells: Array[Vector2i] = []
	parent.global_position = tile_map.map_to_local(tl) + extents/2.0
	cells = registered_node.footprint.get_occupied_cells(tl)
		
	highlight_cells(cells)

func highlight_cells(cells: Array[Vector2i]) -> void:
	# Remove previous highlights
	for cell in highlighted_cells:
		highlight_map.set_cell(cell, -1)
	highlighted_cells = cells.duplicate()

	# Draw new highlights
	for cell in highlighted_cells:
		if occupied_cells.has(cell) or tile_map.get_cell_source_id(cell) != 4: # NOTE: Atlas ID 4 is used for placeable_area_tiles in tilemap
			highlight_map.set_cell(cell, 1, highlight_atlas_coords) # Based on Atlast ID 1 == red
		else:
			highlight_map.set_cell(cell, 0, highlight_atlas_coords) # Based on Atlas ID 0 == green

func clear_highlights() -> void:
	for cell in highlighted_cells:
		highlight_map.set_cell(cell, -1)
	highlighted_cells.clear()

func register(node: PlaceableComponent) -> void:
	registered_node = node

func update_hover(mouse_position: Vector2) -> void:
	update_highlight()

func unregister() -> void:
	registered_node = null
	if is_valid_placement():
		occupied_cells.append_array(highlighted_cells)
	clear_highlights()

func is_valid_placement() -> bool:
	var valid: bool = true
	for cell in highlighted_cells:
		if highlight_map.get_cell_source_id(cell) == 1:
			valid = false
			break
	return valid
