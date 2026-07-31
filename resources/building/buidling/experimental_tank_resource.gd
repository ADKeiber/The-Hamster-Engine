class_name ExperimentalTankResource
extends BuildingResource


func turn_on(hamster : Hamster, cage : CageInteractableComponent) -> void:
	var hamster_traits : Array = hamster.hamster_stats_component._stats.traits
	var max_traits : int = hamster.hamster_stats_component._stats.max_traits
	var added : bool = false
	if hamster_traits.size() < max_traits:
		while added == false:
			var new_trait = Database.all_traits.pick_random()
			if hamster_traits.has(new_trait) == false:
				hamster_traits.append(new_trait)
				added = true
	elif hamster_traits.size() >= max_traits:
		turn_off(hamster, cage)
