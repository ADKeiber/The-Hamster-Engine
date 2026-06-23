class_name IncreaseRosterSizeModule
extends MachineModule


func start_module() -> void:
	GScript.roster_limit = GScript.roster_limit + 1
	GScript.add_hamster_slot.emit()
