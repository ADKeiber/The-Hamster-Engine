class_name HealthyHideCondition
extends Condition
## Reduces health burn
 
@export var health_burn_decrease: int

func apply(hamster: Hamster, origin: Node) -> void:
	self.hamster = hamster
	self.origin = origin
	
func remove() -> void:
	hamster.remove_condition(self)
	self.hamster = null

func handle_event(event: Event) -> void:
	if event.type == Event.Type.HEALTH_BURN:
		event.data["amount"] -= health_burn_decrease
