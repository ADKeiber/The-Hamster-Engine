class_name PollutionTouched
extends Condition
## Adds "permanent" health to a hamster
@export var health_increase: int
@export var speed_increase: int

func apply(hamster: Hamster) -> void:
	self.hamster = hamster
	var stats_component: HamsterStatsComponent = hamster.hamster_stats_component
	var max_health: = stats_component.StatType.MAX_HEALTH
	var speed: = stats_component.StatType.SPEED
	stats_component.set_stat_value(max_health, stats_component.get_stat(max_health) + health_increase)
	stats_component.set_stat_value(speed, stats_component.get_stat(speed) + speed_increase)
	
func remove() -> void:
	var stats_component: HamsterStatsComponent = hamster.hamster_stats_component
	var max_health: = stats_component.StatType.MAX_HEALTH
	var speed: = stats_component.StatType.SPEED
	stats_component.set_stat_value(max_health, stats_component.get_stat(max_health) - health_increase)
	stats_component.set_stat_value(speed, stats_component.get_stat(speed) - speed_increase)
	self.hamster = null

func tick() -> void:
	pass
