class_name TaintedFoodCondition
extends Condition
## The food is tainted! Decrease the speed of hamsters... Maybe do timer to remove?

@export var speed_decrease: int

func apply(hamster: Hamster, origin:Node) -> void:
	self.origin = origin
	self.hamster = hamster
	var stats_component: HamsterStatsComponent = hamster.hamster_stats_component
	var speed: = stats_component.StatType.SPEED
	stats_component.set_stat_value(speed, stats_component.get_stat(speed) - speed_decrease)
	
func remove() -> void:
	var stats_component: HamsterStatsComponent = hamster.hamster_stats_component
	var speed: = stats_component.StatType.SPEED
	stats_component.set_stat_value(speed, stats_component.get_stat(speed) + speed_decrease)
	hamster.remove_condition(self)
	self.hamster = null

func handle_event(event: Event) -> void:
	pass ## Isn't a reactive condition
