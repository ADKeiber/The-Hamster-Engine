class_name VisitorManager
extends Node2D
var visitor:VisitorResource
var started: bool = false
@onready var visitor_popup_expanded: VisitorPopupExpanded = $VisitorPopupExpanded
@onready var visitor_popup_small: VisitorPopupSmall = $VisitorPopupSmall
@onready var visitor_sprite: Sprite2D = $"VisitorScene(MakeItsOwnThingLater)/VisitorSprite"
@onready var timer: Timer = $Timer

signal switch_popup

func _ready() -> void:
	switch_popup.connect(switch_popup_visible)

func set_visitor(visitor: VisitorResource) -> void: 
	self.visitor = visitor
	visitor_sprite.global_position = visitor.waiting_position
	visitor_popup_expanded.set_popup_info(visitor)
	visitor_popup_small.set_popup_info(visitor)
	visitor_sprite.texture = visitor.sprite
	visitor_popup_small.visible = false

func switch_popup_visible() -> void:
	if not started:
		started = true
		timer.start(visitor.time_to_complete * 60)
	visitor_popup_small.visible = not visitor_popup_small.visible
	visitor_popup_expanded.visible = not visitor_popup_expanded.visible
