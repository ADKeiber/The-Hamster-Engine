class_name Event
extends RefCounted

var type : Type
var source: Node
var data : Dictionary
var hamster: Hamster

enum Type {
	HEALTH_CHANGED,
	STAMINA_CHANGED,
	CONDITION_ADDED,
	CONDITION_REMOVED,
	TICK, ## Every Second (tick) something happens
	BUILDING_ENTERED,
	BUILDING_EXITED,
	CREATED,
	ACTIVATE_NEW_TRAIT, ## This is used for traits that either do something when new traits are added OR is a trigger for that newly added trait (see toxic resilience)
	STAMINA_REGEN,
	HEALTH_BURN,
	HEAL
	}

func _init(
	event_type: Type,
	event_source: Node,
	hamster: Hamster,
	event_data: Dictionary = {}):
	self.hamster = hamster
	type = event_type
	source = event_source
	data = event_data
