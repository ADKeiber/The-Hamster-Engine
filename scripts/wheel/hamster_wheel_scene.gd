class_name HamsterWheelsScene
extends Control
#@onready var hamster_wheel_slot: HamsterWheelSlot = $Panel/VBoxContainer/HamsterWheelSlots/MarginContainer6/HamsterWheelSlot
@onready var wheel_slot_upgrade: MarginContainer = %WheelSlotUpgrade
const HAMSTER_WHEEL_SLOT = preload("res://scenes/wheel/hamster_wheel_slot.tscn")
@onready var hamster_wheel_slots: HBoxContainer = %HamsterWheelSlots


func _ready() -> void:
	GScript.add_wheel.connect(reveal_wheel)
	# generate wheels
func setup_wheels() -> void:
	for i in range(GScript.num_of_wheels):
		var margin_container := MarginContainer.new()
		margin_container.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
		var slot = HAMSTER_WHEEL_SLOT.instantiate()
		margin_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		margin_container.add_child(slot)
		hamster_wheel_slots.add_child(margin_container)
		
func reveal_wheel() -> void:
	var margin_container := MarginContainer.new()
	margin_container.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	var slot = HAMSTER_WHEEL_SLOT.instantiate()
	margin_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	margin_container.add_child(slot)
	hamster_wheel_slots.add_child(margin_container)
