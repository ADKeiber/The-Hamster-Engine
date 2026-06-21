class_name HamsterCageSlot
extends Control
const HAMSTER = preload("res://scenes/hamster.tscn")
var _hamster : HamsterUI

func add_hamster(stats:HamsterStats) -> void:
	var hamster: HamsterUI = HAMSTER.instantiate()
	#TODO set hamster_ui sprite possibly?
	add_child(hamster)
	hamster.position = self.size / 2.0

func reparent_hamster(hamster: HamsterUI) -> void:
	print("Reparent")
	hamster.reparent(self)
	hamster.position = self.size / 2.0
	_hamster = hamster
	if _hamster.picked_up.is_connected(self.hamster_picked_up): #make sure connection is disconnected
		_hamster.picked_up.disconnect(self.hamster_picked_up)
	if hamster.hamster_state != hamster.State.RESTING: #change hamster state if not changed
		hamster.hamster_state = hamster.State.RESTING
		hamster.change_states()
	hamster.picked_up.connect(self.hamster_picked_up)

func hamster_picked_up() -> void:
	if _hamster.hamster_state != _hamster.State.IDLE: #change hamster state if not changed
		_hamster.hamster_state = _hamster.State.IDLE
		_hamster.change_states()
	# disconnect hamster from this specific wheel
	if _hamster.picked_up.is_connected(self.hamster_picked_up): 
		_hamster.picked_up.disconnect(self.hamster_picked_up)
	_hamster = null 
