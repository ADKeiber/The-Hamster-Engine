class_name GlobalEffects
extends Node

signal effects_updated
signal show_more_effect_details(show:bool, effect: GlobalEffect)

var timer: Timer

var all_effects: Array[GlobalEffect]

func set_timer(world_timer: Timer) -> void:
	timer = world_timer

func add_global_effect(effect: GlobalEffect, node: Node) -> void:
	all_effects.append(effect)
	effect.apply_effect(node)
	timer.timeout.connect(effect.apply_effect)
	effects_updated.emit()

func remove_global_effect(effect: GlobalEffect) -> void:
	if not has_effect(effect):
		return
	effect.remove_effect()
	all_effects.erase(effect)
	timer.timeout.disconnect(effect.apply_effect)
	effects_updated.emit()

func has_effect(effect: GlobalEffect) -> bool:
	for e in all_effects:
		if e.get_script() == effect.get_script():
			return true
	return false
