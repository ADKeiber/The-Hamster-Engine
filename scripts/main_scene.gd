class_name MainScene
extends Control

@export var starting_hamsters: Array[HamsterStats]
@export var all_modules: Array[MachineModule]
@onready var hamster_cage_scene: HamsterCageScene = %HamsterCageScene

func _ready() -> void:
	GScript.roster = starting_hamsters
	hamster_cage_scene.generate_slots_and_hamsters()
	GScript.all_modules = all_modules
	

#this exists just for debugging... Allows me to print exactly what is being clicked
#func _input(event):
	#if event is InputEventMouseButton and event.pressed:
		#var hovered = get_viewport().gui_get_hovered_control()
		#print("Hovered Control: ", hovered)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("Closing popups")
		GScript.close_popups.emit()
