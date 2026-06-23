class_name HamsterStats
extends Resource

var id: int
@export var stamina: int
@export var speed: int
@export var health: int
@export var chance_to_take_damage: float

func increase_random_stat(amount: int):
	match randi_range(0, 2):
		0:
			stamina += amount
		1:
			speed += amount
		2:
			health += amount
