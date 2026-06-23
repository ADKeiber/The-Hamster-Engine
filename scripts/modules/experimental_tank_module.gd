class_name ExperimentalTankModule
extends MachineModule

var hamster: HamsterStats
var first_start: bool = true
#this can be triggered when a hamster is dropped into the area 2D...
# make sure to set the hamster variable first.. might need to be a
#hamster_ui instead of stats.. more testing needed
func start_module() -> void:
	if first_start:
		GScript.hamster_watts_min = GScript.hamster_watts_min + min_power_increase
		first_start = false
	if hamster == null:
		return
	#interact with a timer probably or emit an event instead of doing it directly
	hamster.increase_random_stat(1)
