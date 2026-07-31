class_name IronStomachTrait
extends TraitResource
##Iron Gut should make hamster immune to bad food effects.. and also
## restores my stamina from food (while in
@export var percent_stamina_increase: float = 0.25

func handle_event(event: TraitEvent, stats: HamsterStatsComponent) -> void:
	match event.type:
		TraitEvent.EventType.CONDITION_ADDED:
			var type: HamsterStatsComponent.StatType
			if event.data["condition_type"] == "food" and event.data["is_positive"]:
				event.hamster.remove_condition(event.data["condition"]) ## Remove condition for bad food related
		TraitEvent.EventType.STAMINA_REGEN:
			if event.source == Cage:
				event.hamster.stamina_component.rest(stats.get_stat(HamsterStatsComponent.StatType.STAMINA_GEN) * percent_stamina_increase)
				## NOTE: This just adds the EXTRA stamina that would be generated... the base amount is added somewhere else...
