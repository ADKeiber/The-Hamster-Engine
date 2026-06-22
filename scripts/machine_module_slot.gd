class_name MachineModuleSlot
extends Control

@export var is_project_module: bool
@export var disabled: bool
@export var slot_number: int
@onready var module_option_popup: PanelContainer = %AvailableModulesPopup
#@onready var texture: TextureRect = $Texture
#@onready var mod_name: Label = $VBoxContainer/Name
#@onready var description: RichTextLabel = $VBoxContainer/Description
@onready var texture_rect: TextureRect = $TextureRect

var current_module: MachineModule

# Called when the node enters the scene tree for the first time.
#
func _ready():
	GScript.close_popups.connect(close_popup)
	z_index = 1
	if disabled:
		modulate = Color.BLACK
	else:
		modulate = Color.WHITE
	GScript.unlock_module.connect(unlock)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if disabled:
					return
				if not module_option_popup.visible:
					GScript.close_popups.emit()
					#z_index = 1
				module_option_popup.visible = not module_option_popup.visible
				if module_option_popup.visible:
					module_option_popup.reset_options(is_project_module)
					z_index = 100
				
				accept_event()

func close_popup() -> void:
	z_index = 10
	module_option_popup.visible = false

func set_module(module:MachineModule) -> void:
	texture_rect.texture = module.texture
	current_module = module
	module.installed = true
	module.start_module()
	print("Installed!")

func unlock(slot_to_unlock:int, is_project_slot: bool) -> void:
	if slot_to_unlock != self.slot_number || is_project_module != is_project_slot:
		return
	disabled = false
	if disabled:
		modulate = Color.BLACK
	else:
		modulate = Color.WHITE
