class_name Rest extends Condition

func apply(hamster: Hamster) -> void:
	self.hamster = hamster

func remove() -> void:
	hamster = null 

func tick() -> void:
	var stats: HamsterStatsComponent = hamster.hamster_stats_component
	hamster.health_component.heal(stats.get_stat(HamsterStatsComponent.StatType.HEALING))
	hamster.stamina_component.rest(stats.get_stat(HamsterStatsComponent.StatType.STAMINA_GEN))
