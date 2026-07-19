class_name PowerDrainEffect extends GlobalEffect

@export var amount: int = 0
func apply_effect() -> void:
	print("DRAINING MORE POWER!!")
	Power.min_power += amount

func remove_effect() -> void:
	print("Finished effect... power minimum returned to normal")
	Power.min_power -= amount
