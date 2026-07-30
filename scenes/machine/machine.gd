class_name Machine
extends Node2D

var machine_resource: MachineResource
@onready var animation_component: AnimationComponent = $AnimationComponent

func set_up_machine(machine: MachineResource) -> void:
	machine_resource = machine
	animation_component.sprite_frames = machine_resource.sprite
	
