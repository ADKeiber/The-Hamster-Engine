class_name AvailableModulesPopup
extends PanelContainer

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
			var option: MachineModuleOption = MACHINE_MODULE_OPTION.instantiate()
			options_container.add_child(option)
			option.set_option(module)
