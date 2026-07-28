extends Control
class_name hamster_ui


@onready var health_bar : TextureProgressBar = $HealthBar
@onready var current_health : Label = $HealthBar/current
@onready var stamina_bar : TextureProgressBar = $StaminaBar
@onready var current_stamina : Label = $StaminaBar/current
@onready var speed : Label = $ColorRect/Speed
@onready var hamster : Hamster = $".."

func _process(delta: float) -> void:
	health_bar.max_value = hamster.hamster_stats_component._stats.max_health
	stamina_bar.max_value = hamster.hamster_stats_component._stats.max_stamina
	health_bar.value = hamster.health_component.current_health
	stamina_bar.value = hamster.stamina_component.current_stamina
	current_health.text = str(int(health_bar.value))
	current_stamina.text = str(int(stamina_bar.value))
	speed.text = str(hamster.hamster_stats_component._stats.speed)
