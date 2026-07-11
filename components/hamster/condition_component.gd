class_name ConditionComponent extends Node

@export var stats: HamsterStatsComponent
var conditions: Array[Condition] = []

signal condition_added(condition: Condition)
signal condition_removed(condition: Condition)

func add_condition(condition: Condition) -> void:
	if has_condition(condition):
		return
	conditions.append(condition)
	condition.apply(get_parent())
	condition_added.emit(condition)
	get_parent().timer.timeout.connect(condition.tick)

func remove_condition(condition: Condition) -> void:
	if not has_condition(condition):
		return
	conditions.erase(condition)
	condition.remove()
	condition_removed.emit(condition)
	get_parent().timer.timeout.disconnect(condition.tick)

func has_condition(condition: Condition) -> bool:
	for c in conditions:
		if c.get_script() == condition.get_script():
			return true
	return false

func clear_conditions() -> void:
	for condition in conditions:
		condition.remove()
	conditions.clear()

func get_conditions() -> Array[Condition]:
	return conditions.duplicate()
