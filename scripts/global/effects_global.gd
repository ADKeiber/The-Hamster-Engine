class_name GlobalEffects
extends Node

signal effects_updated
signal show_more_effect_details(show:bool, effect: GlobalEffect)

var timer: Timer

var all_effects: Array[GlobalEffect]
var ids: Array[int]
func set_timer(world_timer: Timer) -> void:
	timer = world_timer

func add_global_effect(effect: GlobalEffect, node: Node) -> void:
	all_effects.append(effect)
	effect.apply_effect(node)
	timer.timeout.connect(effect.apply_effect)
	ids.append(effect.instance_id)
	effects_updated.emit()

func remove_global_effect(effect: GlobalEffect) -> void:
	if not has_effect(effect):
		return
	effect.remove_effect()
	all_effects.erase(effect)
	timer.timeout.disconnect(effect.apply_effect)
	ids.erase(effect.instance_id)
	effects_updated.emit()

func has_effect(effect: GlobalEffect) -> bool:
	for e in all_effects:
		if e.get_script() == effect.get_script():
			return true
	return false

func get_ids() -> Array[int]:
	return ids

func get_by_id(id: int) -> GlobalEffect:
	for effect in all_effects:
		if id == effect.instance_id:
			return effect
	return null
