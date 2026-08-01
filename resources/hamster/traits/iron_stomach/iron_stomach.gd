class_name IronStomachTrait
extends TraitResource
##Iron Gut should make hamster immune to bad food effects.. and also
## restores my stamina from food (while in cage)
@export var percent_stamina_increase: float = 0.25

func handle_event(event: Event, stats: HamsterStatsComponent) -> void:
	match event.type:
		Event.Type.CONDITION_ADDED:
			var type: HamsterStatsComponent.StatType
			if event.data["condition_type"] == "food" and not event.data["is_positive"]:
				event.hamster.remove_condition(event.data["condition"]) ## Remove condition for bad food related
		Event.Type.STAMINA_REGEN:
			if event.source == Cage:
				event.data["amount"] = event.data["amount"] + (event.data["amount"] * percent_stamina_increase)
