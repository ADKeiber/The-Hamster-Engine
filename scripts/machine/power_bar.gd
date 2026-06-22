class_name ExcessPowerBar
extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	value -= GScript.power_drain
	value += GScript.power_generated
