class_name TraitEvent
extends RefCounted

var type : EventType
var source: Node
var data : Dictionary
var hamster: Hamster

enum EventType {
	HEALTH_CHANGED,
	STAMINA_CHANGED,
	CONDITION_ADDED,
	CONDITION_REMOVED,
	TICK,
	BUILDING_ENTERED,
	BUILDING_EXITED,
	CREATED,
	ACTIVATE_NEW_TRAIT, ## This is used for traits that either do something when new traits are added OR is a trigger for that newly added trait (see toxic resilience)
	STAMINA_REGEN
	}

func _init(
	event_type: EventType,
	event_source: Node,
	hamster: Hamster,
	event_data: Dictionary = {}):
	self.hamster = hamster
	type = event_type
	source = event_source
	data = event_data
