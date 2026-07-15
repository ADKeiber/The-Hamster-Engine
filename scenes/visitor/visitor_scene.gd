class_name VisitorScene
extends Node2D

signal open_large_popup(visitor:VisitorResource)

@onready var visitor_popup_small: VisitorPopupSmall = $VisitorPopupSmall
@onready var visitor_popup_tiny: VisitorPopupTiny = %VisitorPopupTiny
@onready var timer: Timer = $TimeRemaining

var visitor: VisitorResource
var time_remaining: int = 0

func _ready() -> void:
	timer.timeout.connect(end_encounter)

func _process(delta:float) -> void:
	if visitor != null:
		time_remaining = round(timer.time_left)
		visitor_popup_tiny.set_time(format_time(time_remaining))
		visitor_popup_small.set_time(format_time(time_remaining))

func setup_visitor(visitor: VisitorResource) -> void:
	self.visitor = visitor
	visitor_popup_small.set_popup_info(visitor)
	visitor_popup_small.visible = false
	visitor_popup_tiny.visible = false
	timer.wait_time = visitor.time_to_complete

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("left_mouse") and event.pressed:
		visitor_popup_small.visible = not visitor_popup_small.visible
		visitor_popup_tiny.visible = not visitor_popup_small.visible

func start_timer() -> void:
	timer.start()

func format_time(total_seconds: int) -> String:
	var minutes := total_seconds / 60
	var seconds := total_seconds % 60
	return "%02d:%02d" % [minutes, seconds]

func end_encounter() -> void:
	queue_free()
