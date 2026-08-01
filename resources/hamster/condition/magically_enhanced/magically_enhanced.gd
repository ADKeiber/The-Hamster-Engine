class_name MagicallyEnhanced extends Condition

@export var speed_increase: int
@export var health_increase: int
@export var stamina_increase: int

func apply(hamster: Hamster, node:Node) -> void:
	self.hamster = hamster
	var stats: HamsterStatsComponent = hamster.hamster_stats_component
	stats.set_stat_value(HamsterStatsComponent.StatType.SPEED, 
		stats.get_stat(HamsterStatsComponent.StatType.SPEED) + speed_increase)
	stats.set_stat_value(HamsterStatsComponent.StatType.MAX_HEALTH, 
		stats.get_stat(HamsterStatsComponent.StatType.MAX_HEALTH) + health_increase)
	stats.set_stat_value(HamsterStatsComponent.StatType.MAX_STAMINA, 
		stats.get_stat(HamsterStatsComponent.StatType.MAX_STAMINA) + stamina_increase)

func remove() -> void:
	var stats: HamsterStatsComponent = hamster.hamster_stats_component
	stats.set_stat_value(HamsterStatsComponent.StatType.SPEED, 
		stats.get_stat(HamsterStatsComponent.StatType.SPEED) - speed_increase)
	stats.set_stat_value(HamsterStatsComponent.StatType.MAX_HEALTH, 
		stats.get_stat(HamsterStatsComponent.StatType.MAX_HEALTH) - health_increase)
	stats.set_stat_value(HamsterStatsComponent.StatType.MAX_STAMINA, 
		stats.get_stat(HamsterStatsComponent.StatType.MAX_STAMINA) - stamina_increase)
	hamster.remove_condition(self)
	hamster = null
