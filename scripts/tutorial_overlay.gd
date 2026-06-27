class_name TutorialOverlay
extends Control

var current_step: TutorialStep
@onready var margin_container: MarginContainer = $MarginContainer
@onready var margin_container_2: MarginContainer = $MarginContainer2
@onready var margin_container_3: MarginContainer = $MarginContainer3
@onready var margin_container_4: MarginContainer = $MarginContainer4
@onready var margin_container_5: MarginContainer = $MarginContainer5

func set_step(step:TutorialStep) -> void:
	current_step = step
	print("NEW STEP")

func _on_button_pressed() -> void:
	if current_step.steps_complete == true:
		GScript.complete_step.emit(current_step.step_number)


func _on_part_1_pressed() -> void:
	margin_container.visible = false
	margin_container_2.visible = true
	
func _on_part_2_pressed() -> void:
	margin_container_2.visible = false
	margin_container_3.visible = true


func _on_part_3_pressed() -> void:
	margin_container_3.visible = false
	margin_container_4.visible = true


func _on_part_4_pressed() -> void:
	margin_container_4.visible = false
	margin_container_5.visible = true


func _on_finish_pressed() -> void:
	self.visible = false
	get_tree().paused = false
