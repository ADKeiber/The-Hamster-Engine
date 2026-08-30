class_name GlobalEffect
extends Resource

## This can be used for visitors OR machines effects (in theory)

@export var effect_name: String
@export_multiline var short_description: String
@export_multiline var description: String
#Add more fields later
var applied: bool = false
var origin: Node
var instance_id: int
##Note that this method has the potential to continually be reapplied and the effect 
##can decide if it wants to actually do anything about it
func apply_effect(origin: Node) -> void:
	pass
func remove_effect() -> void:
	pass

func get_long_description() -> String:
	return ""

func _init() -> void:
	var valid_rid: bool = false
	var new_rid: int = randi_range(0, 1000000000)
	while not valid_rid:
		var ge: GlobalEffect = Effects.get_by_id(new_rid)
		if ge != null:
			new_rid = randi_range(0, 1000000000)
		else:
			valid_rid = true
			instance_id = new_rid
