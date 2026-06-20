class_name HamsterCageSlot
extends Control
const HAMSTER = preload("res://scenes/hamster.tscn")


func add_hamster(stats:HamsterStats) -> void:
	var hamster: HamsterUI = HAMSTER.instantiate()
	#TODO set hamster_ui sprite possibly?
	add_child(hamster)
	hamster.position = self.size / 2.0

func reparent_hamster(hamster: HamsterUI) -> void:
	print("Reparent")
	hamster.reparent(self)
	hamster.position = self.size / 2.0
