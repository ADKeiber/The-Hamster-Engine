class_name Basic3Trait extends TraitResource

@export var increase: int = 0

func handle_event(event: Event, stats: HamsterStatsComponent) -> void:
	match event.type:
		Event.Type.CREATED:
			var type: HamsterStatsComponent.StatType
			match randi_range(0, 2):
				0: type = HamsterStatsComponent.StatType.MAX_HEALTH
				1: type = HamsterStatsComponent.StatType.MAX_STAMINA
				2: type = HamsterStatsComponent.StatType.SPEED
			stats.set_stat_value(type, stats.get_stat(type) + increase)
		_:
			print("Not handled")
