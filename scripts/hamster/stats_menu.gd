extends Control


@export var health_stat : Label
@export var stamina_stat : Label
@export var speed_stat : Label
@export var trait_stat : Label
@export var hamster : HamsterUI


func stat_setup() -> void:
	health_stat.text = "Health: " + str(hamster.stats.health)
	stamina_stat.text = "Stamina: " + str(hamster.stats.stamina)
	speed_stat.text = "Speed: " + str(hamster.stats.speed)
	trait_stat.text = "Trait: " + hamster.hamster_trait["Name"] + " " + hamster.hamster_trait["Description"]
	
