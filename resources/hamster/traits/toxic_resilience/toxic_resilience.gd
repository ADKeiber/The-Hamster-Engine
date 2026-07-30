class_name ToxicResilience
extends TraitResource

@export var percent_health_increase: float = 0.5

var already_applied: bool = false
func handle_event(event: TraitEvent, stats: HamsterStatsComponent ) -> void:
	if event.type == TraitEvent.EventType.ACTIVATE_NEW_TRAIT:
		if event.data["newTriat"] == ToxicResilience && not already_applied:
			stats.set_stat_value(stats.StatType.MAX_HEALTH, stats.get_stat(stats.StatType.MAX_HEALTH) 
				+ stats.get_stat(stats.StatType.MAX_HEALTH) * percent_health_increase)
			already_applied = true
