class_name MachineModuleSlot
extends Control
@onready var module_option_popup: PanelContainer = %AvailableModulesPopup


# Called when the node enters the scene tree for the first time.
#
func _ready():
	GScript.close_popups.connect(close_popup)
	z_index = 1

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if not module_option_popup.visible:
					GScript.close_popups.emit()
					z_index = 1
				module_option_popup.visible = not module_option_popup.visible
				z_index = 100
				accept_event()

func close_popup() -> void:
	module_option_popup.visible = false
