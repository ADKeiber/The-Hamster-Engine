class_name HamsterWheelSlot
extends Control
const HAMSTER = preload("res://scenes/hamster/hamster.tscn")
var _hamster : HamsterUI


# Manually placed slots in
func reparent_hamster(hamster: HamsterUI) -> void:
	print("Reparent")
	hamster.reparent(self)
	hamster.position = self.size / 2.0
	$"Panel/Hamster Wheel".power_wheel() ##start wheel animation
	_hamster = hamster
	if _hamster.picked_up.is_connected(self.hamster_picked_up): 
		_hamster.picked_up.disconnect(self.hamster_picked_up)
	if hamster.hamster_state != hamster.State.RUNNING:
		hamster.hamster_state = hamster.State.RUNNING
		GScript.power_generated += _hamster.stats.speed * 0.01
		GScript.hamster_watts_produced += _hamster.stats.speed * 10
		hamster.change_states()
	hamster.picked_up.connect(self.hamster_picked_up)
	
	
	
# Stops the wheel animation
func hamster_picked_up() -> void:
	$"Panel/Hamster Wheel".power_off()
	if _hamster.hamster_state != _hamster.State.IDLE:
		_hamster.hamster_state = _hamster.State.IDLE
		GScript.power_generated -= _hamster.stats.speed * 0.01
		GScript.hamster_watts_produced -= _hamster.stats.speed * 10
		_hamster.change_states()
	# disconnect hamster from this specific wheel
	if _hamster.picked_up.is_connected(self.hamster_picked_up): 
		_hamster.picked_up.disconnect(self.hamster_picked_up)
	_hamster = null
	
