extends Node

var max_power : int = 1000
var min_power : int
var current_power : int = 200:
	set(value):
		current_power = clamp(value, 0, max_power)

var power_produced : int = 0

func _process(_delta: float) -> void:
	current_power += power_produced - min_power
