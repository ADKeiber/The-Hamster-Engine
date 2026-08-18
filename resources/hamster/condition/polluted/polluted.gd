class_name Polluted
extends Condition
## NOTE: This doesn't have any intrinsic effect.. BUT there are things/events that will
## Directly interact with hamsters who are "polluted"

func apply(hamster: Hamster, origin: Node) -> void:
	self.origin = origin
	self.hamster = hamster
	self.hamster.add_condition(self, origin)
	
func remove() -> void:
	#LEaving this here.. BUT DO NOT DO THIS! Don't call remove_condition inside the remove
	# Will create infinite recursion.. just undo effects if needed otherwise do nothing
	#hamster.condition_component.remove_condition(self) 
	self.hamster = null

func handle_event(event: Event) -> void:
	pass ## Doesn't do anything with events
