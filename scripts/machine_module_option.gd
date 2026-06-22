class_name MachineModuleOption
extends HBoxContainer
@onready var option_texture_rect: TextureRect = $Texture
@onready var option_name: Label = $VBoxContainer/Name
@onready var option_description: RichTextLabel = $VBoxContainer/Description
var module: MachineModule
func set_option(module: MachineModule) -> void:
	self.module = module
	option_texture_rect.texture = module.texture
	option_name.text = module.module_name
	option_description.text = module.module_description
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				print("Selected: ", option_name.text)
				var machine_slot_ancestor: MachineModuleSlot = get_machine_module_slot()
				machine_slot_ancestor.set_module(self.module)
				GScript.close_popups.emit()

func get_machine_module_slot() -> MachineModuleSlot:
	var current = self
	while current:
		if current is MachineModuleSlot:
			return current
		current = current.get_parent()
	return null
