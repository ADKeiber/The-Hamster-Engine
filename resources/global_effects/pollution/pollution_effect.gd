class_name PollutionEffect extends GlobalEffect

@export var number_of_hamster: int = 0 ## Determines how many hamsters should take damage
@export var damage: int = 0 ## Determines how much damage should happen
@export var time_between_impact: float = 5.0
@export var condition: Condition

var calculated_ticks: bool = false
var total_ticks: int = 0
var ticks_remaining: int = 0
##NOTE: This one keeps getting applied.. Its not a one and done thing :)
func apply_effect(origin: Node) -> void:
	self.origin = origin
	if not calculated_ticks:
		total_ticks = int(time_between_impact / Effects.timer.wait_time)
		ticks_remaining = total_ticks
		calculated_ticks = true
	
	##Applied polluted condition to hamsters
	for hamster in Hamsters.hamsters:
		hamster.condition_component.add_condition(condition, origin)
		
	ticks_remaining -= 1
	if ticks_remaining == 0:
		print("Doing %s damager to hamsters" % damage) 
		##Gets random hamsters to damage 
		var damanged_hamsters: Dictionary[Hamster, bool]
		if number_of_hamster >= Hamsters.hamsters.size():
			for hamster in  Hamsters.hamsters:
				damanged_hamsters[hamster] = true
		else:
			for i in range(number_of_hamster):
				var next_hamster:Hamster = Hamsters.get_random_hamster()
				while damanged_hamsters.has(next_hamster): ## This will trigger if a hamster hasn't been added to damage
					next_hamster = Hamsters.get_random_hamster()
				damanged_hamsters[next_hamster] = true
		
		##Applies the damage
		for hamster in damanged_hamsters:
			hamster.health_component.take_damage(damage)
		ticks_remaining = total_ticks

func remove_effect() -> void:
	print("Stopped doing damage to hamsters and remove polluted condition!")
	for hamster in Hamsters.hamsters:
		hamster.condition_component.remove_condition(condition)
