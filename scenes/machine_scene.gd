class_name MachineScene
extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%"2ndLayer".hide()
	%"3rdLayer".hide()
	GScript.complete_project_module.connect(complete_module)
	#%"Base".stop()

func complete_module(mod_num: int) -> void:
	#Trust me this was required... otherwise the layers would be on different 
	#frames and the pipes would float and stuff.. did the same for the main menu
	match mod_num:
		1: 
			%"2ndLayer".show()
			%"Base".stop()
			%"2ndLayer".stop()
			%"Base".play()
			%"2ndLayer".play()
		2: 
			%"Base".stop()
			%"2ndLayer".stop()
			%"3rdLayer".stop()
			%"3rdLayer".show()
			%"Base".play()
			%"2ndLayer".play()
			%"3rdLayer".play()
