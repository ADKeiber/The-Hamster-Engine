class_name HealthyHideEvent
extends GlobalEffect

@export var condition: Condition

func apply_effect(origin: Node) -> void:
	self.origin = origin
	for hamster in Hamsters.hamsters:
		hamster.add_condition(condition, null)

func remove_effect() -> void:
	pass
