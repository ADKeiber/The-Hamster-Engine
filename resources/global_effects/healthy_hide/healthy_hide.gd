class_name HealthyHideEvent
extends GlobalEffect

@export var condition: Condition

func apply_effect() -> void:
	for hamster in Hamsters.hamsters:
		hamster.add_condition(condition)

func remove_effect() -> void:
	pass
