class_name GlobalEffect
extends Resource

## This can be used for visitors OR machines effects (in theory)

@export var effect_name: String
@export_multiline var short_description: String
@export_multiline var description: String
#Add more fields later
var applied: bool = false
var origin: Node
##Note that this method has the potential to continually be reapplied and the effect 
##can decide if it wants to actually do anything about it
func apply_effect(origin: Node) -> void:
	pass
func remove_effect() -> void:
	pass

func get_long_description() -> String:
	return ""
