class_name BatteryCapacityIncreaseModule
extends MachineModule

@export var amount_to_increase: int

func start_module() -> void:
	print("Increasing battery capacity..")
	print("Previous capacity: ", GScript.batter_capacity)
	GScript.batter_capacity = GScript.batter_capacity + amount_to_increase
	print("New capacity: ", GScript.batter_capacity)
