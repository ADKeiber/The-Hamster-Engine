class_name Polluted
extends Condition
## NOTE: This doesn't have any intrinsic effect.. BUT there are things/events that will
## Directly interact with hamsters who are "polluted"



func apply(hamster: Hamster) -> void:
	self.hamster = hamster
func remove() -> void:
	self.hamster = null
func tick() -> void:
	pass
