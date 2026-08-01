class_name TraitsComponent extends Node

var stats_component: HamsterStatsComponent

func on_event(event: Event) -> void:
	for t in stats_component.get_stats().traits:
		t.handle_event(event, stats_component)
