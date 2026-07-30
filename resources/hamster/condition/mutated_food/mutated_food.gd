class_name MutatedFoodCondition
extends Condition
## hamsters have eating a mutated food! Grants them slightly increased stamina regeneration

@export var stamina_gen_increase: int

func apply(hamster: Hamster) -> void:
	self.hamster = hamster
	var stats_component: HamsterStatsComponent = hamster.hamster_stats_component
	var stam_gen: = stats_component.StatType.STAMINA_GEN
	stats_component.set_stat_value(stam_gen, stats_component.get_stat(stam_gen) + stamina_gen_increase )
	
func remove() -> void:
	var stats_component: HamsterStatsComponent = hamster.hamster_stats_component
	var stam_gen: = stats_component.StatType.STAMINA_GEN
	stats_component.set_stat_value(stam_gen, stats_component.get_stat(stam_gen) - stamina_gen_increase)
	self.hamster = null

func tick() -> void:
	pass
