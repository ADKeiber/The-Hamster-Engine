class_name PollutionMutation extends GlobalEffect

@export var applied_condition: Condition

func apply_effect() -> void:
	if not applied:
		for hamster in Hamsters.hamsters:
			hamster.condition_component.add_condition(applied_condition)
		applied = true

func remove_effect() -> void:
	for hamster in Hamsters.hamsters:
		hamster.condition_component.remove_condition(applied_condition)
