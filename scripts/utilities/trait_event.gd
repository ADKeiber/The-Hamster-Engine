class_name TraitEvent
extends RefCounted

var type : EventType
var source: Node
var data : Dictionary

enum EventType {
	HEALTH_CHANGED,
	STAMINA_CHANGED,
	CONDITION_ADDED,
	CONDITION_REMOVED,
	TICK,
	BUILDING_ENTERED,
	BUILDING_EXITED,
	CREATED
	}
	
func _init(
	event_type: EventType,
	event_source: Node,
	event_data: Dictionary = {}):
	type = event_type
	source = event_source
	data = event_data
