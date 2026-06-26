class_name CompleteProjectModule1
extends MachineModule


func start_module() -> void:
	print("Project Module 1 starting")
	GScript.unlock_module.emit(3, false)
	GScript.unlock_module.emit(4, false)
	GScript.unlock_module.emit(2, true)
	GScript.complete_project_module.emit(1)
	GScript.hamster_watts_min = GScript.hamster_watts_min + min_power_increase
