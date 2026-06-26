class_name AvailableModulesPopup
extends PopupPanel

const MACHINE_MODULE_OPTION = preload("res://scenes/machine/machine_module_option.tscn")
@onready var options_container: VBoxContainer = %OptionsContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func reset_options(is_project_module:bool) -> void:
	#delete existing options
	for child in options_container.get_children():
		child.queue_free()
	#Create options that currently are selectable
	for module in GScript.all_modules:
		if not module.installed && is_project_module == module.project_module: #checks 
			var parent: MachineModuleSlot = get_parent()
			if is_project_module && not parent.slot_number == module.project_module_num: #TODO FIX THIS WONKY SHIT
				continue
			var option: MachineModuleOption = MACHINE_MODULE_OPTION.instantiate()
			options_container.add_child(option)
			option.set_option(module)
			if GScript.current_battery_value < option.module.power_cost:
				option.disable()
			else:
				option.enable()
