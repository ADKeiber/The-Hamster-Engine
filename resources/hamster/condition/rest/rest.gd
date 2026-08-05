class_name Rest extends Condition

func apply(hamster: Hamster, origin: Node) -> void:
	self.hamster = hamster
	self.origin = origin
	print("Rest added")

func remove() -> void:
	hamster.remove_condition(self)
	hamster = null 

func handle_event(event: Event) -> void:
	if event.type == Event.Type.TICK:
		var stats: HamsterStatsComponent = hamster.hamster_stats_component
		hamster.health_component.heal(stats.get_stat(HamsterStatsComponent.StatType.HEALING))
		hamster.stamina_component.rest(stats.get_stat(HamsterStatsComponent.StatType.STAMINA_GEN))
		var stamina_event: Event = Event.new(Event.Type.STAMINA_REGEN, origin, hamster, {
			"amount":stats.get_stat(HamsterStatsComponent.StatType.STAMINA_GEN)
			})
		hamster.handle_event(stamina_event)
		hamster.stamina_component.rest(stamina_event.data["amount"])
		print("rest")
