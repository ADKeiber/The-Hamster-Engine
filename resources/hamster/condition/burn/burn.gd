class_name Burn extends Condition

@export var amount: int
var condition_origin: Node

func apply(hamster: Hamster, origin: Node) -> void:
	self.hamster = hamster
	condition_origin = origin

func remove() -> void:
	hamster = null 

func handle_event(event: Event) -> void:
	if event.type == Event.Type.TICK:
		var burn_event: Event = Event.new(Event.Type.HEALTH_BURN, condition_origin, hamster, {"amount": amount})
		hamster.handle_event(burn_event)
		hamster.health_component.take_damage(burn_event["amount"])
