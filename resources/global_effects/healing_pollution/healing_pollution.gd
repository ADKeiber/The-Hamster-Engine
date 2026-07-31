class_name HealingPollution
extends GlobalEffect

@export var number_of_hamster: int = 0 ## Determines how many hamsters should health
@export var healing: int = 0 ## Determines how much healing should happen
@export var time_between_impact: float = 5.0
@export var chance_to_heal: float = .75

var calculated_ticks: bool = false
var total_ticks: int = 0
var ticks_remaining: int = 0
##NOTE: This one keeps getting applied.. Its not a one and done thing :)
func apply_effect() -> void:
	
	if not calculated_ticks:
		total_ticks = int(time_between_impact / Effects.timer.wait_time)
		ticks_remaining = total_ticks
		calculated_ticks = true
		
	ticks_remaining -= 1
	if ticks_remaining == 0:
		##Gets random hamsters to damage 
		var healed_hamsters: Dictionary[Hamster, bool]
		if number_of_hamster >= Hamsters.hamsters.size():
			for hamster in  Hamsters.hamsters:
				healed_hamsters[hamster] = true
		else:
			for i in range(number_of_hamster):
				var next_hamster:Hamster = Hamsters.get_random_hamster()
				var missing_health: bool = next_hamster.health_component.get_max_health() > next_hamster.health_component.current_health
				while healed_hamsters.has(next_hamster) && missing_health: ## This will trigger if a hamster hasn't been added to heal and is missing health
					next_hamster = Hamsters.get_random_hamster()
					missing_health = next_hamster.health_component.get_max_health() > next_hamster.health_component.current_health
				healed_hamsters[next_hamster] = true
		
		##Applies the damage
		for hamster in healed_hamsters:
			if randf_range(0,1.0) <= chance_to_heal:
				print("Healing Hamster") 
				hamster.health_component.heal(healing)
		ticks_remaining = total_ticks

func remove_effect() -> void:
	pass ## Nothing to do here... just stop healing
