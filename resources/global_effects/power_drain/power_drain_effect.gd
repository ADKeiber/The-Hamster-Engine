class_name PowerDrainEffect extends GlobalEffect

@export var amount: int = 0
func apply_effect(origin: Node) -> void:
	self.origin = origin
	if not applied:
		print("DRAINING MORE POWER!!")
		Power.min_power += amount
		applied = true

func remove_effect() -> void:
	print("Finished effect... power minimum returned to normal")
	Power.min_power -= amount


func get_long_description() -> String:
	return description % [amount]
