class_name HamsterCageScene
extends Control

const HAMSTER_CAGE_SLOT = preload("res://scenes/cage/hamster_cage_slot.tscn")
@onready var hamster_slots: HBoxContainer = %HamsterSlots
const HAMSTER = preload("res://scenes/hamster/hamster.tscn")

# Called when the node enters the scene tree for the first time.
func generate_slots_and_hamsters() -> void:
	#Generates the slots dynamically
	for i in range(GScript.roster_limit):
		var slot: HamsterCageSlot = HAMSTER_CAGE_SLOT.instantiate()
		hamster_slots.add_child(slot)
		var control: Control = Control.new()
		control.size_flags_horizontal = Control.SIZE_EXPAND | Control.SIZE_FILL
		hamster_slots.add_child(control)
		if i < len(GScript.roster):
			slot.add_hamster(GScript.roster[i])
