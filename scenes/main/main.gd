class_name Main
extends Control
@onready var visitor_manager: VisitorManager = %VisitorManager
const WIZARD_VISITOR = preload("uid://44v42uuevygw")

const BASIC_STORE = preload("uid://d2xunjkruqawl")
@onready var world_timer: Timer = %WorldTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Power.set_timer(world_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	visitor_manager.start_event()
