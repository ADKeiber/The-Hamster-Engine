class_name HamsterUI
extends Node2D

signal picked_up

var stats: HamsterStats = preload("res://resources/basic_hamster.tres")
var dragging: bool
var amount: int = 0
var drag_offset := Vector2.ZERO
var slot_position := Vector2.ZERO
var target: Area2D
enum State {IDLE, RUNNING, RESTING} #Hamster must always be in a State
var hamster_state : State = State.IDLE

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

func _on_area_2d_area_exited(area: Area2D) -> void:
	target = null
	
func _ready() -> void:
	$AnimatedSprite2D.play("idle")

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


func _on_stamina_bar_damage() -> void:
	$HealthPipsContainer.take_damage()
