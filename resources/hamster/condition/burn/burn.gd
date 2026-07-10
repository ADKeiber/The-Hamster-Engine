class_name Burn extends Condition

@export var amount: int

func apply(hamster: Hamster) -> void:
	self.hamster = hamster

func remove() -> void:
	hamster = null 

func tick() -> void:
	hamster.health_component.take_damage(amount)
