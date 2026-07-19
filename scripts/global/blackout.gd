class_name Blackout
extends PanelContainer

@export var resource: VisitorResource

var original_z_indexes: Dictionary = {}


func _ready() -> void:
	self.mouse_filter = Control.MOUSE_FILTER_STOP

func show_dark_overlay(groups_to_highlight: Array[String]) -> void:
	visible = true

	for group_name in groups_to_highlight:
		for node in get_tree().get_nodes_in_group(group_name):
			if node is CanvasItem:
				if not original_z_indexes.has(node):
					original_z_indexes[node] = node.z_index

				node.z_index = 4001


func hide_dark_overlay() -> void:
	visible = false

	for node in original_z_indexes:
		if is_instance_valid(node):
			node.z_index = original_z_indexes[node]
	original_z_indexes.clear()
