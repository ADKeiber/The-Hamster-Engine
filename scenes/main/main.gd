class_name Main
extends Control
@onready var visitor_manager: VisitorManager = %VisitorManager

const BASIC_STORE = preload("uid://d2xunjkruqawl")
@onready var world_timer: Timer = %WorldTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var basic_store : VisitorResource = BASIC_STORE.duplicate(true)
	visitor_manager.set_visitor(basic_store)
	Power.set_timer(world_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
