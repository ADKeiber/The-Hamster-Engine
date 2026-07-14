class_name StoreSlot
extends PanelContainer
@onready var badge: Badge = $Wrapper/Badge
@onready var wrapper: Control = $Wrapper

var item: Node2D

func set_item(node: Node2D, cost: int) -> void:
	badge.set_value(cost)
	item = node
	wrapper.add_child(node)
	wrapper.move_child(node,0)
	item.position = size * 0.5
