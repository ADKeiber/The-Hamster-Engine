class_name HamsterTypeComponent extends Node

var stats_component: HamsterStatsComponent

func on_event(event: Event) -> void:
	stats_component.get_stats().hamster_type.hamster_trait.handle_event(event, stats_component)
