class_name MachineModuleSlot
extends Control

@export var is_project_module: bool
@export var disabled: bool
@export var slot_number: int
@onready var module_option_popup: PopupPanel = %AvailableModulesPopup
@onready var texture_rect: TextureRect = $TextureRect

var current_module: MachineModule
var allow_hamster_reparent: bool = false
var _hamster: HamsterUI

var remaining_interaction_ticks: int

func _ready():
	GScript.close_popups.connect(close_popup)
	z_index = 1
	if disabled:
		modulate = Color.BLACK
	else:
		modulate = Color.WHITE
	GScript.unlock_module.connect(unlock)
	$Timer.wait_time = GScript.global_tick_time 

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if disabled:
					return
				if not module_option_popup.visible:
					GScript.close_popups.emit()
					#z_index = 1
				if module_option_popup.visible:
					module_option_popup.visible = false
				elif not module_option_popup.visible and current_module == null:
					#module_option_popup.
					var center_x = self.global_position.x + self.size.x / 2.0
					var x = center_x - module_option_popup.size.x / 2.0
					var y = self.global_position.y + self.size.y
					module_option_popup.position = Vector2(x, y)
					module_option_popup.visible = true
				if module_option_popup.visible:
					module_option_popup.reset_options(is_project_module)
					z_index = 100
				accept_event()

func close_popup() -> void:
	z_index = 10
	module_option_popup.visible = false

func set_module(module:MachineModule) -> void:
	allow_hamster_reparent = module.interactable
	texture_rect.texture = module.texture
	current_module = module
	module.installed = true
	module.start_module()
	$ProgressBar.max_value = module.ticks_to_complete_interaction
	$ProgressBar.value = module.ticks_to_complete_interaction
	remaining_interaction_ticks = module.ticks_to_complete_interaction
	print("Installed!")

func unlock(slot_to_unlock:int, is_project_slot: bool) -> void:
	if slot_to_unlock != self.slot_number || is_project_module != is_project_slot:
		return
	disabled = false
	if disabled:
		modulate = Color.BLACK
	else:
		modulate = Color.WHITE

#func interact_with_hamster(hamster: HamsterUI) -> void:
	##Start timer
	##

func reparent_hamster(hamster: HamsterUI) -> void:
	print("Reparent")
	hamster.reparent(self)
	hamster.position = self.size / 2.0
	current_module.interact_with_hamster(hamster, $Timer, $ProgressBar)

func is_interactable() -> bool:
	return current_module != null and current_module.interactable

func _on_timer_timeout() -> void:
	if remaining_interaction_ticks > 0:
		pass
