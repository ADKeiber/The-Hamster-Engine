class_name VisitorManager
extends Node2D

signal start_timer_for_visitor(visitor: VisitorScene)
signal leave(visitor: VisitorScene)

@export var max_visitors: int = 3
@export var visitor_anchors: Array[Vector2] ## this is relative to where the door exists :)
@export var potential_visitors: Array[VisitorResource]

@onready var door_animation: AnimationComponent = %DoorAnimation
@onready var exclamation_animation: AnimationComponent = %ExclamationAnimation
@onready var visitor_popup_expanded: VisitorPopupLarge = $VisitorPopupLarge
@onready var timer: Timer = $Timer
@onready var active_visitors: Node2D = $ActiveVisitors
@onready var knock_timer: Timer = $KnockTimer

var space_occupied: Array[bool] = []## this isn't probably the best way to do this but it will determine which slots are filled
var visitor_in_space: Dictionary ## Dictionary[VisitorScene, int]
var visitors: VisitorScene
var active_visitor_scene: VisitorScene
var event_waiting: bool = false
const VISITOR_SCENE = preload("uid://bkowbvt4v88sc")

func _ready() -> void:
	for i in range(max_visitors):
		space_occupied.append(false)
	leave.connect(animate_visitor_leaving)
	exclamation_animation.modulate.a = 0

##User to start the event and is the "Knock" and exclamation
func start_event() -> void:
	if not event_waiting and get_first_non_occupied_anchor() != -1:
		door_animation.play_animation_once_and_stop(AnimationComponent.AnimationState.KNOCKING)
		exclamation_animation.play_animation_once_and_stop(AnimationComponent.AnimationState.EXCLAMATION)
		exclamation_animation.modulate.a = 1
		event_waiting = true

##Sets the information for the large popup, pauses all enemy timers AND 
func set_visitor_large_popup(visitor: VisitorResource) -> void: 
	var visitor_node:VisitorScene = find_visitor_using_resource(visitor)
	if visitor_node != null:
		visitor_node.visitor_popup_small.visible = false
		visitor_node.visitor_popup_tiny.visible = false
	visitor_popup_expanded.set_popup_info(visitor_node)
	visitor_popup_expanded.visible = true
	var blackout_curtain:Blackout = get_tree().get_nodes_in_group("Blackout")[0]
	visitor_node.add_to_group("FocusedVisitor")
	blackout_curtain.show_dark_overlay(["Battery", "MachineEffects", "FocusedVisitor", "VisitorPopup"])
	disable_visitor_smaller_popups()
	pause_visitors(true)

func spawn_visitor() -> void:
	var visitor: VisitorScene = VISITOR_SCENE.instantiate()
	## use visitorspawner instead of this to get a resource
	var vis_resource:VisitorResource = potential_visitors[randi_range(0, potential_visitors.size() - 1)].duplicate(true)
	active_visitors.add_child(visitor)
	visitor.setup_visitor(vis_resource)
	start_timer_for_visitor.connect(start_timer)
	visitor.open_large_popup.connect(set_visitor_large_popup)
	#animation to position
	visitor_in_space[visitor] = get_first_non_occupied_anchor() ## sets the visitor and their anchors
	animate_to_position(visitor, get_first_non_occupied_anchor(), false)

func start_timer(visitor_scene: VisitorScene) -> void:
	visitor_scene.popups_disabled = false
	visitor_scene.start_timer()
	visitor_scene.visitor_popup_tiny.visible = true
	visitor_popup_expanded.visible = false
	expand_tiny_for_all()

func door_click_input(viewport: Node, event: InputEvent, shape_idx: int) -> void: ## input_event_handler
	if event.is_action("left_mouse") and event.pressed and event_waiting:
		exclamation_animation.modulate.a = 0
		door_animation.play_animation_once_and_stop(AnimationComponent.AnimationState.OPENING)
		door_animation.animation_finished.connect(spawn_visitor, CONNECT_ONE_SHOT)
		event_waiting = false

##############################################
## Animation Related #########################
##############################################
func animate_to_position(visitor_scene: VisitorScene, anchor_index: int, leaving: bool) -> void:
	visitor_scene.animation_component.update_animation(AnimationComponent.AnimationState.WALKING)
	var tween := create_tween()
	active_visitor_scene = visitor_scene
	var modifier: int = -0.5 if leaving else 1
	tween.tween_property(
		visitor_scene,
		"position",
		visitor_anchors[anchor_index] * modifier,
		2.0
	)
	space_occupied[anchor_index] = not leaving ## basically If its leaving we want it false because its no longer occupied
	## but if its not leaving (entering) then we want it true :)
	await tween.finished
	if not leaving:
		set_visitor_large_popup(active_visitor_scene.visitor)
		door_animation.play_animation_once_and_stop(AnimationComponent.AnimationState.CLOSING)
		visitor_scene.animation_component.update_animation(AnimationComponent.AnimationState.IDLE)
	else:
		visitor_scene.queue_free()

##############################################
## Pop-up interactions #######################
##############################################
func disable_visitor_smaller_popups() -> void:
	for visitor in active_visitors.get_children():
		if visitor is VisitorScene:
			visitor.popups_disabled = true
			visitor.visitor_popup_small.visible = false
			visitor.visitor_popup_tiny.visible = false

func animate_visitor_leaving(leaving_visitor: VisitorScene) -> void:
	door_animation.play_animation_once_and_stop(AnimationComponent.AnimationState.OPENING)
	await door_animation.animation_finished
	await animate_to_position(leaving_visitor, visitor_in_space[leaving_visitor], true)
	door_animation.play_animation_once_and_stop(AnimationComponent.AnimationState.CLOSING)

##############################################
## Helpers ###################################
##############################################
func get_first_non_occupied_anchor() -> int:
	for i in range(space_occupied.size()):
		if space_occupied[i] == false:
			return i
	return -1

func pause_visitors(paused: bool) -> void:
	for child in active_visitors.get_children():
		if child is VisitorScene:
			child.pause_timer(paused)

func find_visitor_using_resource(visitor_resource: VisitorResource) -> VisitorScene:
	for child in active_visitors.get_children():
		if visitor_resource == child.visitor:
			return child
	return null

func expand_tiny_for_all() -> void:
	for child in active_visitors.get_children():
		if child is VisitorScene:
			child.visitor_popup_tiny.visible = true
			child.visitor_popup_small.visible = false
			child.popups_disabled = false
