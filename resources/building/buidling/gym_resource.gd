extends BuildingResource
class_name GymResource

@export var stat_upgrade : int
enum Stat {HEALTH, STAMINA, SPEED}

func turn_on(hamster : Hamster, cage : CageInteractableComponent) -> void:
	var hamster_stats_component = hamster.hamster_stats_component
	var rand_stat : int = randi_range(Stat.HEALTH, Stat.SPEED)
	
	var current_stat = hamster_stats_component.get_stat(rand_stat)
	var new_stat : int = current_stat + stat_upgrade
	hamster_stats_component.set_stat_value(rand_stat, new_stat)
	
	prints(Stat.find_key(rand_stat), current_stat, new_stat)
