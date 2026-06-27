class_name TutorialOverlay
extends Control

var current_step: TutorialStep

func set_step(step:TutorialStep) -> void:
	current_step = step
	print("NEW STEP")

func _on_button_pressed() -> void:
	if current_step.steps_complete == true:
		GScript.complete_step.emit(current_step.step_number)
