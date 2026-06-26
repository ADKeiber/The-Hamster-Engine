class_name MachineModule
extends Resource

#TODO Some of these are only used when the module is interactable... 
#We could seperate these into different classes at some point BUT not now
@export_group("Base")
@export var module_name: String
@export var module_description: String
@export var power_cost: int
@export var texture: Texture2D
@export var min_power_increase: int
@export var project_module: bool # maybe should be an enum... BUT there are only 2 options right now... Project and Hamster Modules
@export var project_module_num: int # this should only be used if project_module == true
@export var installed: bool = false

#For interactable modules.. Not all will use these
@export_group("Interactions")
@export var interactable: bool = false
@export var animated_texture: AnimatedTexture
@export var ticks_to_complete_interaction: int = 0 # This is how many ticks to complete the interaction... see GScript.global_tick_time
@export var interact_power_cost: int
#Upgradeable modules.. not all modules will be upgradeable
@export_group("Upgrades")
@export var upgradeable: bool = false
@export var module_to_upgrade: MachineModule
@export var callables: Array[Callable]
#TODO !! IDEA !! Can have an enum for upgrade type.. some replace functionality, some do additional functions

func start_module() -> void:
	pass

#method either will or won't be implemented depending on
#interactable variable
func interact_with_hamster(hamster:HamsterUI, timer: Timer, progress_bar: ProgressBar) -> void:
	pass
