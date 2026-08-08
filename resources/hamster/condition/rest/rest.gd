class_name Rest extends Condition

func apply(hamster: Hamster, origin: Node) -> void:
	self.hamster = hamster
	self.origin = origin
	print("Rest added")

func remove() -> void:
	if hamster != null:
		hamster.remove_condition(self)
		hamster = null 

func handle_event(event: Event) -> void:
	if event.type == Event.Type.TICK:
		if hamster != null:
			var stats: HamsterStatsComponent = hamster.hamster_stats_component
			var stamina_event: Event = Event.new(Event.Type.STAMINA_REGEN, origin, hamster, {
				"amount":stats.get_stat(HamsterStatsComponent.StatType.STAMINA_GEN)
				})
			hamster.handle_event(stamina_event)
			hamster.stamina_component.rest(stamina_event.data["amount"])
			var health_event: Event = Event.new(Event.Type.HEAL, origin, hamster, {
				"amount":stats.get_stat(HamsterStatsComponent.StatType.HEALING)
				})
			hamster.handle_event(health_event)
			hamster.health_component.heal(health_event.data["amount"])
			prints("rest", hamster)
