extends Control


@export var produced : Label
@export var min : Label
@export var total : Label

func _ready() -> void:
	pass



func _process(delta: float) -> void:
	produced.text = "Produced: " + str(Power.power_produced)
	min.text = "Min: " + str(Power.min_power)
	total.text = "Total: " + str(Power.current_power)
