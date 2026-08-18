class_name Main
extends Control

signal win_game

@onready var visitor_manager: VisitorManager = %VisitorManager
@onready var machine_manager: Control = %MachineManager

const WIZARD_VISITOR = preload("uid://44v42uuevygw")

const BASIC_STORE = preload("uid://d2xunjkruqawl")
@onready var world_timer: Timer = %WorldTimer
@onready var start_machine: Button = $StartMachine
@onready var you_win_screen: PanelContainer = %YouWinScreen

# Called when the node ente$StartMachiners the scene tree for the first time.
func _ready() -> void:
	Power.set_timer(world_timer)
	Visitor.set_timer(world_timer)
	Effects.set_timer(world_timer)
	win_game.connect(win)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	visitor_manager.start_event()

func _on_start_machine_pressed() -> void:
	machine_manager.set_timer(world_timer)
	machine_manager.spawn_next_machine()

func win() -> void:
	you_win_screen.visible = true
	get_tree().paused = true

func _on_world_timer_timeout() -> void:
	for hamster in Hamsters.hamsters:
		hamster.handle_event(Event.new(Event.Type.TICK, world_timer, hamster, {}))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var pos :Vector2 = event.position
		var control := get_viewport().gui_get_hovered_control()

		print("Hovered Control: ", control)
