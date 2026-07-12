extends Node

var max_power : int
var min_power : int
var current_power : int = 200:
	set(value):
		current_power = clamp(value, 0, max_power)

var power_produced : int = 0
