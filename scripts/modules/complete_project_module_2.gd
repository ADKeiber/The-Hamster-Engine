class_name CompleteProjectModule2
extends MachineModule


func start_module() -> void:
	print("Project Module 2 starting")
	GScript.unlock_module.emit(5, false)
	GScript.unlock_module.emit(6, false)
	GScript.unlock_module.emit(3, true)
	GScript.complete_project_module.emit(2)
	GScript.hamster_watts_min = GScript.hamster_watts_min + min_power_increase
