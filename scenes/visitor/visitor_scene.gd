class_name VisitorScene
extends Node2D

signal open_large_popup(visitor:VisitorResource)

@onready var visitor_popup_tiny: VisitorPopupTiny = %VisitorPopupTiny
@onready var animation_component: AnimationComponent = $AnimationComponent
@onready var mouth: Node2D = %Mouth
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var visitor_popup_small

var popups_disabled: bool
var visit_started: bool
var is_pasued: bool
var visitor: VisitorResource
var time_remaining: int = 0 ## in seconds

func _ready() -> void:
	Visitor.pass_time.connect(reduce_time_left)

func setup_visitor(visitor: VisitorResource) -> void:
	self.visitor = visitor
	animation_component.sprite_frames = visitor.sprite_frames
	visitor_popup_small = visitor.small_popup.instantiate()
	add_child(visitor_popup_small)
	visitor_popup_small.set_popup_info(visitor)
	var offset: Vector2 = visitor_popup_small.global_position - visitor_popup_small.entry_as_global()
	var top_middle_of_visitor: Vector2 = Vector2(collision_shape_2d.global_position.x + (collision_shape_2d.shape.size.x/2), self.global_position.y)
	visitor_popup_small.global_position = collision_shape_2d.global_position + offset - Vector2(0, collision_shape_2d.shape.size.y/2)
	visitor_popup_small.visible = false
	visitor_popup_tiny.visible = false
	time_remaining = visitor.time_to_complete
	visitor_popup_tiny.set_time(format_time(time_remaining))
	visitor_popup_small.set_time(format_time(time_remaining))

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("left_mouse") and event.pressed and not popups_disabled:
		visitor_popup_small.visible = not visitor_popup_small.visible
		visitor_popup_tiny.visible = not visitor_popup_small.visible

func reduce_time_left() -> void:
	if visit_started and not is_pasued:
		if time_remaining == 0:
			exit()
		time_remaining -= 1 
		visitor_popup_tiny.set_time(format_time(time_remaining))
		visitor_popup_small.set_time(format_time(time_remaining))

func start_timer() -> void:
	if not visit_started:
		visit_started = true

func format_time(total_seconds: int) -> String:
	var minutes := total_seconds / 60
	var seconds := total_seconds % 60
	return "%02d:%02d" % [minutes, seconds]

func pause_timer(paused: bool) -> void:
	is_pasued = paused

func end_encounter() -> void:
	queue_free()

func get_mouth_position() -> Vector2: 
	return mouth.global_position

func exit() -> void:
	popups_disabled = true
	visitor_popup_tiny.visible = false
	visitor_popup_small.visible = false
	
	if visitor is TimedDifficulty:
		visitor.remove_difficulty()
	get_parent().get_parent().leave.emit(self) ## yuck (maybe change later)
