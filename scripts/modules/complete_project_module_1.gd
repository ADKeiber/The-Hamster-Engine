class_name CompleteProjectModule1
extends MachineModule


func start_module() -> void:
	GScript.unlock_module.emit(3, false)
	GScript.unlock_module.emit(4, false)
	GScript.unlock_module.emit(2, true)
	GScript.hamster_watts_min = GScript.hamster_watts_min + min_power_increase
	pass
