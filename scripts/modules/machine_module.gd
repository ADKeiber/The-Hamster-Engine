class_name MachineModule
extends Resource

@export var module_name: String
@export var module_description: String
@export var power_cost: int
@export var texture: Texture2D
@export var min_power_increase: int
@export var project_module: bool # maybe should be an enum... BUT there are only 2 options right now... Project and Hamster Modules
@export var installed: bool
func start_module() -> void:
	pass
