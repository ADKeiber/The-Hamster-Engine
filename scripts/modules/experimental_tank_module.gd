class_name ExperimentalTankModule
extends MachineModule

var hamster: HamsterStats
#this can be triggered when a hamster is dropped into the area 2D...
# make sure to set the hamster variable first.. might need to be a
#hamster_ui instead of stats.. more testing needed
func start_module() -> void:
	if hamster == null:
		return
	hamster.increase_random_stat(1)
