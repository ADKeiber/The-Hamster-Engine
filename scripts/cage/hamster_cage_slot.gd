class_name HamsterCageSlot
extends Control
const HAMSTER = preload("res://scenes/hamster/hamster.tscn")
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
	hamster.z_index = 0 # Reparenting sets zindex to zero
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

func _on_gui_input(event: InputEvent) -> void: #opens add hamster menu
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			if check_child_type() == false:
				#tutorial logic
				if GScript.in_tutorial:
					if not GScript.purchased_hamster:
						$AddHamsterMenu.show()
					return
				if get_tree().get_node_count_in_group("HamsterUI") < GScript.roster_limit:
					$AddHamsterMenu.show()

func check_child_type() -> bool:
	for child in self.get_children():
		if is_instance_of(child, HamsterUI):
			return true
	return false
	
#for tutorial
const BASIC_HAMSTER = preload("res://resources/basic_hamster.tres")

func _on_add_hamster_pressed() -> void:
	if GScript.current_battery_value >= 100:
		if not GScript.purchased_hamster:
			GScript.purchased_hamster = true
			GScript.first_hamster_purchased.emit()
		if GScript.in_tutorial:
			add_hamster(BASIC_HAMSTER.duplicate(true))
		else:
			add_hamster(GScript.hamster_options[0].duplicate(true))
		GScript.current_battery_value -= 100
		$AddHamsterMenu.hide()
		$Click.play()

@export var button : Button
func _process(delta: float) -> void: #disables button while curent power is too low to purchase
	if GScript.current_battery_value < 100:
		button.disabled = true
	else: button.disabled = false

func is_empty() -> bool:
	return _hamster == null
