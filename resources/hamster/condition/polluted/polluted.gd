class_name Polluted
extends Condition
## NOTE: This doesn't have any intrinsic effect.. BUT there are things/events that will
## Directly interact with hamsters who are "polluted"

func apply(hamster: Hamster, origin: Node) -> void:
	self.origin = origin
	self.hamster = hamster
	
func remove() -> void:
	hamster.remove_condition(self)
	self.hamster = null

func handle_event(event: Event) -> void:
	pass ## Doesn't do anything with events
