class_name IncreaseWheelCountModule
extends MachineModule


func start_module() -> void:
	GScript.num_of_wheels = GScript.num_of_wheels + 1
	GScript.add_wheel.emit()
