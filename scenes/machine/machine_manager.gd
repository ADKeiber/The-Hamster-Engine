class_name MachineManager
extends Control

@export var machines: Array[MachineResource]
@export var machine_durations: Array[int]

@onready var remaining_time: RichTextLabel = %RemainingTime
@onready var machine_reward: PanelContainer = %MachineReward
@onready var machines_holder: Node2D = %MachinesHolder
@onready var machine_zone: PanelContainer = $MachineZone

var current_effects: Array[GlobalEffect]
var current_time_remaining: int = 10
var timer: Timer
var current_machine_index: int = 0
var spawning_machine: bool = false
const MACHINE = preload("uid://dfd1o456ncvt6")
var offset: int = 170 ## x offset to slide the machine

func spawn_next_machine() -> void:
	spawning_machine = true
	var new_machine: MachineResource = machines[current_machine_index]
	#Animate Other machines moving (if not current_machine_index == 0)
	
	if current_machine_index != 0:
		var tween := create_tween()
		for machine in machines_holder.get_children():
			
			tween.parallel().tween_property(
				machine,
				"global_position",
				Vector2(machine.global_position.x - offset, machine.global_position.y),
				2.0
			)
		await tween.finished
	
	#Animate the machine coming in
	var machine_scene: Machine = MACHINE.instantiate()
	machines_holder.add_child(machine_scene)
	machine_scene.set_up_machine(new_machine)
	var position: Vector2 = Vector2(0, machine_zone.size.y - 45)
	#machine_scene.global_position = Vector2(position.x,0)

	var tween := create_tween()
	tween.tween_property(
		machine_scene,
		"position",
		position,
		1.0
	)
	await tween.finished
	#Set Timer
	
	#update effects (UI AND actual effects impacts)
	spawning_machine = false
	current_time_remaining = machine_durations[current_machine_index]
	remaining_time.text = str(current_time_remaining)
	await pass_time()
	add_global_effect(new_machine.initial_effect)
	

func set_timer(world_timer: Timer) -> void:
	timer = world_timer
	timer.timeout.connect(pass_time)
	
func pass_time() -> void:
	if not spawning_machine:
		current_time_remaining -= 1
		remaining_time.text = str(current_time_remaining)
		
		if current_time_remaining == 0:
			if machines_holder.get_child_count(false) == 3:
				print("YOU WIN!")
				spawning_machine = true
				get_parent().win_game.emit()
				return
			machine_reward.set_reward_1(machines[current_machine_index].reward_1_effects[0],machines[current_machine_index].reward_1_effects[1])
			machine_reward.set_reward_2(machines[current_machine_index].reward_2_effects[0],machines[current_machine_index].initial_effect)
			machine_reward.visible = true
			var blackout_curtain:Blackout = get_tree().get_nodes_in_group("Blackout")[0]
			blackout_curtain.show_dark_overlay(["MachineRewardPopup", "MachineEffects", "Battery"])
			get_tree().paused = true

######################################
## Global Effect Handling ############
######################################

func add_global_effect(effect: GlobalEffect) -> void:
	current_effects.append(effect)
	effect.apply_effect()
	var timer: Timer = get_tree().get_first_node_in_group("WorldTimer")
	timer.timeout.connect(effect.apply_effect)

func remove_global_effect(effect: GlobalEffect) -> void:
	if not has_effect(effect):
		return
	current_effects.erase(effect)
	var timer: Timer = get_tree().get_first_node_in_group("WorldTimer")
	timer.timeout.disconnect(effect.apply_effect)
	effect.remove_effect()

func has_effect(effect: GlobalEffect) -> bool:
	for e in current_effects:
		if e.get_script() == effect.get_script():
			return true
	return false

##Should add 2 positive effects AND maintain the negative effect
func reward_1_pressed() -> void:
	var machine: MachineResource = machines[current_machine_index]
	for effect in machine.reward_1_effects:
		add_global_effect(effect)
	current_machine_index += 1
	current_time_remaining = machine_durations[current_machine_index]
	remaining_time.text = str(current_time_remaining)
	machine_reward.visible = false
	get_tree().paused = false
	var blackout_curtain: Blackout = get_tree().get_first_node_in_group("Blackout")
	blackout_curtain.hide_dark_overlay()
	spawn_next_machine()

##Should add a single positive effect and remove the negative one
func reward_2_pressed() -> void:
	var machine: MachineResource = machines[current_machine_index]
	for effect in machine.reward_2_effects:
		add_global_effect(effect)
	remove_global_effect(machine.initial_effect)
	current_machine_index += 1
	current_time_remaining = machine_durations[current_machine_index]
	remaining_time.text = str(current_time_remaining)
	machine_reward.visible = false
	get_tree().paused = false
	var blackout_curtain: Blackout = get_tree().get_first_node_in_group("Blackout")
	blackout_curtain.hide_dark_overlay()
	spawn_next_machine()
