class_name VisitorManager
extends Node2D

signal start_timer_for_visitor(visitor: VisitorResource)

@onready var visitor_popup_expanded: VisitorPopupExpanded = $VisitorPopupExpanded
@onready var timer: Timer = $Timer
@onready var active_visitors: Node2D = $ActiveVisitors

const VISITOR_SCENE = preload("uid://bkowbvt4v88sc")
const BASIC_STORE = preload("uid://d2xunjkruqawl")

func start_event() -> void:
	var visitor := VISITOR_SCENE.instantiate()
	var vis_resource := BASIC_STORE.duplicate(true)
	active_visitors.add_child(visitor)
	visitor.setup_visitor(vis_resource)
	
	start_timer_for_visitor.connect(start_timer)
	visitor.open_large_popup.connect(set_visitor)
	set_visitor(vis_resource)

func set_visitor(visitor: VisitorResource) -> void: 
	var visitor_node:VisitorScene = find_visitor_using_resource(visitor)
	if visitor_node != null:
		visitor_node.visitor_popup_small.visible = false
		visitor_node.visitor_popup_tiny.visible = false
	visitor_popup_expanded.set_popup_info(visitor)
	visitor_popup_expanded.visible = true

func start_timer(visitor: VisitorResource) -> void:
	var visitor_node := find_visitor_using_resource(visitor)
	visitor_node.start_timer()
	visitor_node.visitor_popup_tiny.visible = true
	visitor_popup_expanded.visible = false

func find_visitor_using_resource(visitor_resource: VisitorResource) -> VisitorScene:
	for child in active_visitors.get_children():
		if visitor_resource == child.visitor:
			return child
	return null
