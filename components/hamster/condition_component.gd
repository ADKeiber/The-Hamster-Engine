class_name ConditionComponent extends Node

@export var stats: HamsterStatsComponent
var conditions: Array[Condition] = []

signal condition_added(condition: Condition)
signal condition_removed(condition: Condition)

func on_event(event: Event) -> void:
	for condition in conditions:
		condition.handle_event(event)

func add_condition(condition: Condition, origin:Node) -> void:
	if has_condition(condition):
		return
	conditions.append(condition)
	condition.apply(get_parent(), origin)
	condition_added.emit(condition)
	var timer: Timer = get_tree().get_first_node_in_group("WorldTimer")
	#timer.timeout.connect(condition.tick)

func remove_condition(condition: Condition) -> void:
	if not has_condition(condition):
		return
	conditions.erase(condition)
	condition.remove()
	condition_removed.emit(condition)
	var timer: Timer = get_tree().get_first_node_in_group("WorldTimer")
	#timer.timeout.disconnect(condition.tick)

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
