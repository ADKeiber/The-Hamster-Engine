class_name Badge
extends PanelContainer

@onready var label: Label = $Label

func set_value(value: int):
	label.text = str(value)
