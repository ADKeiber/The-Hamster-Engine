class_name HamsterWheelSlot
extends Control
const HAMSTER = preload("res://scenes/hamster/hamster.tscn")
var _hamster : HamsterUI
@export var wheel : HamsterWheel
@export var squeak : AudioStreamPlayer2D

# Manually placed slots in
func reparent_hamster(hamster: HamsterUI) -> void:
	print("Reparent")
	hamster.reparent(self)
	hamster.position = self.size / 2.0
	$"Hamster Wheel".power_wheel() ##start wheel animation
	_hamster = hamster
	if _hamster.damage.is_connected(self.take_damage): 
		_hamster.damage.disconnect(self.take_damage)
	if _hamster.picked_up.is_connected(self.hamster_picked_up): 
		_hamster.picked_up.disconnect(self.hamster_picked_up)
	if hamster.hamster_state != hamster.State.RUNNING:
		hamster.hamster_state = hamster.State.RUNNING
		GScript.hamster_watts_produced += _hamster.stats.speed * 10
		hamster.change_states()
	hamster.picked_up.connect(self.hamster_picked_up)
	hamster.damage.connect(self.take_damage)
	
	
	
# Stops the wheel animation
func hamster_picked_up() -> void:
	$"Hamster Wheel".power_off()
	if _hamster.hamster_state != _hamster.State.IDLE:
		_hamster.hamster_state = _hamster.State.IDLE
		GScript.hamster_watts_produced -= _hamster.stats.speed * 10
		_hamster.change_states()
	# disconnect hamster from this specific wheel
	if _hamster.picked_up.is_connected(self.hamster_picked_up): 
		_hamster.picked_up.disconnect(self.hamster_picked_up)
	if _hamster.damage.is_connected(self.take_damage) or _hamster == null: 
		_hamster.damage.disconnect(self.take_damage)
	_hamster = null
	
func take_damage() -> void:
	wheel.damage()
	squeak.play()

	
