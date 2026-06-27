extends Control

@onready var current : Label = $HBoxContainer/VBoxContainer/Current
@onready var minimum : Label = $HBoxContainer/VBoxContainer/Minimum
@onready var modifier : Label = $HBoxContainer/VBoxContainer2/Modifier
@onready var amount : Label = $HBoxContainer/VBoxContainer2/Amount

# Gets current Hamster Watts and updates ui
func _process(delta: float) -> void:
	current.text = "Current: " + str(GScript.hamster_watts_produced) + " HWh"
	minimum.text = "Minimum: " + str(GScript.hamster_watts_min) + " HWh"
	amount.text = str(GScript.power_stored)
	if GScript.power_stored >= 0:
		modifier.text = "Gaining"
		amount.add_theme_color_override("font_color", Color.BLUE)
	elif GScript.power_stored < 0:
		modifier.text = "Losing"
		amount.add_theme_color_override("font_color", Color.RED)
