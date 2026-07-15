class_name VisitorPopupTiny
extends Control

@onready var label: Label = $NinePatchRect/Label

func set_time(time:String) -> void:
	label.text = time


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("left_mouse") and event.pressed:
		get_viewport().set_input_as_handled()
		get_parent().open_large_popup.emit(get_parent().visitor)
