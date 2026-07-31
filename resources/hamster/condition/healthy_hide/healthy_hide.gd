class_name HealthyHideCondition
extends Condition

@export var health_burn_decrease: int

func apply(hamster: Hamster) -> void:
	self.hamster = hamster
	var stats_component: HamsterStatsComponent = hamster.hamster_stats_component
	var health_burn: = stats_component.StatType.HEALTH_BURN
	stats_component.set_stat_value(health_burn, stats_component.get_stat(health_burn) - health_burn_decrease)
	
func remove() -> void:
	var stats_component: HamsterStatsComponent = hamster.hamster_stats_component
	var health_burn: = stats_component.StatType.HEALTH_BURN
	stats_component.set_stat_value(health_burn, stats_component.get_stat(health_burn) + health_burn_decrease)
	self.hamster = null

func tick() -> void:
	pass
