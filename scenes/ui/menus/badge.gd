class_name Badge
extends PanelContainer

@onready var label: Label = $Label

const MIN_SIZE := 16

func set_value(value: int):
	label.text = str(value)
	#await get_tree().process_frame
#
	#var text_size = label.get_theme_font("font").get_string_size(
		#label.text,
		#HORIZONTAL_ALIGNMENT_LEFT,
		#-1,
		#label.get_theme_font_size("font_size")
	#)

	#custom_minimum_size = Vector2(
		#max(MIN_SIZE, text_size.x + 10),
		#MIN_SIZE
	#)
