class_name MainScene
extends Control
signal start_tutorial
@export var hamster_options: Array[HamsterStats]
@export var all_modules: Array[MachineModule]
@export var tutorial_1: TutorialStep
@onready var hamster_cage_scene: HamsterCageScene = %HamsterCageScene
@onready var hamster_wheels_scene: HamsterWheelsScene = %HamsterWheelsScene
var starting_hamsters: Array[HamsterStats]
@onready var you_lose_popup: YouLosePopup = %YouLosePopup
@onready var you_win_popup: YouWinPopup = %YouWinPopup

const STEP_ONE = preload("res://resources/tutorial/step_one.tres")
func _ready() -> void:
	GScript.hamster_options = hamster_options
	for i in GScript.roster_size:
		GScript.roster.append(GScript.hamster_options[0].duplicate(true)) #just gets the one but can set to select random
	hamster_cage_scene.generate_slots_and_hamsters()
	hamster_wheels_scene.setup_wheels()
	#hamster_wheels_scene.generate_wheels()
	GScript.all_modules = all_modules
	GScript.restart_game.connect(restart)
	GScript.start_tutorial.connect(tutorial_setup)
	start_tutorial.connect(show_tutorial)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			return
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			return
		print("Closing popups")
		GScript.close_popups.emit()

func restart() -> void:
	GScript.reset_state()
	get_tree().reload_current_scene()
	print("RESET")

func tutorial_setup() -> void:
	print("LETS GO TUTORIAL")
	hamster_cage_scene.process_mode = Node.PROCESS_MODE_ALWAYS
	#$Battery.process_mode = Node.PROCESS_MODE_ALWAYS

func show_tutorial() -> void:
	$TutorialOverlay.visible = true
