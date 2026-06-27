class_name MachineModuleOption
extends Control

@onready var option_name: Label = %Name
@onready var option_texture_rect: TextureRect = $HBoxContainer/Texture
@onready var option_description: RichTextLabel = $HBoxContainer/VBoxContainer/Description
var module: MachineModule
var disabled: bool = false
@onready var cost: RichTextLabel = %Cost
@onready var minimum_power_increase: RichTextLabel = %MinimumPowerIncrease

func _process(delta: float) -> void:
	if GScript.current_battery_value < module.power_cost:
		disable()
	else:
		enable()

func set_option(module: MachineModule) -> void:
	self.module = module
	option_texture_rect.texture = module.texture
	option_name.text = module.module_name
	option_description.text = module.module_description
	minimum_power_increase.text = "+%s" % str(module.min_power_increase)
	cost.text = str(module.power_cost)

func get_machine_module_slot() -> MachineModuleSlot:
	var current = self
	while current:
		if current is MachineModuleSlot:
			return current
		current = current.get_parent()
	return null

func _on_button_pressed() -> void:
	if disabled:
		return
	print("Selected: ", option_name.text)
	var machine_slot_ancestor: MachineModuleSlot = get_machine_module_slot()
	machine_slot_ancestor.set_module(self.module)
	GScript.current_battery_value -= module.power_cost
	GScript.close_popups.emit()
	$Click.play()

func disable() -> void:
	disabled = true
	modulate = Color.BLACK

func enable() -> void:
	disabled = false
	modulate = Color.WHITE
