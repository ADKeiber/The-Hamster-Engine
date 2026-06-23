class_name ExcessPowerBar
extends ProgressBar

func _ready() -> void:
	max_value = GScript.battery_capacity
	$Timer.start()

func _process(delta: float) -> void:
	$Label.text = str(int(value)) + " HW"
	
	



func _on_timer_timeout() -> void:
	GScript.power_stored = GScript.hamster_watts_produced - GScript.hamster_watts_min
	value += GScript.power_stored
