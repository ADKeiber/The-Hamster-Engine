class_name HamsterUI
extends Node2D

signal picked_up

@export var stats_menu : Control
@export var stats: HamsterStats
@export var traits : HamsterTraits

var dragging: bool
var amount: int = 0
var drag_offset := Vector2.ZERO
var slot_position := Vector2.ZERO
var target: Area2D
enum State {IDLE, RUNNING, RESTING} #Hamster must always be in a State
var hamster_state : State = State.IDLE
var hamster_trait : Dictionary

@onready var stamina: Label = %Stamina
@onready var speed: Label = %Speed
@onready var health: Label = %Health

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	hamster_trait = traits.random_trait(stats)
	setup()

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() + drag_offset
		z_index = 100

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				slot_position = global_position
				picked_up.emit()
				$StatsMenu.hide()
			else:
				dragging = false
				print(target)
				#TODO determine which TYPE of location we are dropping on.. There are 4 options 
				if target == null or target.get_parent() == HamsterUI or check_child_type(target.get_parent(), HamsterUI): #1: Nothing... This should make it snap back to original location
					print(1)
					global_position = slot_position
					self.get_parent().reparent_hamster(self)
				elif target.is_in_group("MachineModule"): #2: Module... The hamster needs to go into the module AND an effect triggers
					print(2)
					print("Nothing implemented for Maching modules... yet!")
					if target.get_parent() is MachineModuleSlot and target.get_parent().is_interactable():
						target.get_parent().reparent_hamster(self)
						print("IS An interactable SLOT")
					else:
						global_position = slot_position
						self.get_parent().reparent_hamster(self)
					#determine if it
				elif target.is_in_group("Wheel"): #3: Wheel... Hamster snaps to wheel AND wheel starts generating
					print(3)
					if target.get_parent() is HamsterWheelSlot: 
						target.get_parent().reparent_hamster(self)
						slot_position = global_position
				elif target.is_in_group("CageSlot"): #4: Cage Slot... hamster snaps to cage slot and starts regening stamina 
					print(4)
					if target.get_parent() is HamsterCageSlot:
						target.get_parent().reparent_hamster(self)
						slot_position = global_position
				else:
					print("landed on something that isn't part of a group... Targets groups: ", target.get_groups())
					global_position = slot_position
					self.get_parent().reparent_hamster(self)

func _on_area_2d_area_entered(area: Area2D) -> void:
	target = area
	print("Entered")

func _on_area_2d_area_exited(area: Area2D) -> void:
	if not $Area2D.has_overlapping_areas():
		target = null
		print("Exited: ", area)
	else:
		target = $Area2D.get_overlapping_areas()[0]

# Sets everything up once hamster is fully ready so nothing triggers too early
func setup() -> void:
	$StatsMenu.stat_setup()
	$StaminaBar.setup_stamina()
	$HealthPipsContainer.setup_health()

# Whenever the hamster changes to a new slot or is picked up change states
# Incorporate into all slot swaps
func change_states() -> void:
	if hamster_state == State.IDLE:
		$AnimatedSprite2D.show()
		$StaminaBar.hide()
		$StaminaBar.stamina_change()
	elif hamster_state == State.RUNNING:
		$AnimatedSprite2D.hide()
		$StaminaBar.show()
		$StaminaBar.stamina_change()
	elif hamster_state == State.RESTING:
		$StaminaBar.show()
		$StaminaBar.stamina_change()

func check_child_type(node, type) -> bool:
	for child in node.get_children():
		if is_instance_of(child, type):
			return true
	return false

#Triggers damagage chance
func _on_stamina_bar_damage() -> void:
	$HealthPipsContainer.take_damage()

#Disconnect hamster kill it
func _on_health_pips_container_death() -> void:
	picked_up.emit()
	$Area2D.hide()
	$AnimationPlayer.play("death")
	await $AnimationPlayer.animation_finished
	queue_free()

func _on_area_2d_mouse_entered() -> void:
	if dragging == true:
		stats_menu.hide()
	else: 
		stats_menu.show()

func _on_area_2d_mouse_exited() -> void:
	stats_menu.hide()

func update_ui() -> void:
	health.text = "Health: %s" % [str(stats.max_health)]
	stamina.text = "Stamina: %s" % [str(stats.stamina)]
	speed.text = "Speed: %s" % [str(stats.speed)]

func increase_random_stat(amount: int):
	increase_stat(randi_range(0, 2), amount)

## stat_to_increase.. 0 = stamina, 1 = speed, 2 = health
func increase_stat(stat_to_increase: int, amount: int):
	match stat_to_increase:
		0: stats.stamina += amount
		1: stats.speed += amount
		2: $HealthPipsContainer.add_one_health() # this would ideally go in update_ui BUT idk how to do that with the current setup
	update_ui()

func heal() -> void:
	$HealthPipsContainer.heal()
