class_name TaintedCropEffect
extends GlobalEffect

@export var condition: Condition

##NOTE: This one keeps getting applied.. Its not a one and done thing :)
## also this should probably only apply it to hamsters who are in the cage... but 
## we will figure out how to determine that later
func apply_effect(origin: Node) -> void:
	self.origin = origin
	##Applied tainted food condition to hamsters
	for hamster in Hamsters.hamsters:
		hamster.condition_component.add_condition(condition, null) #apply effect should take in a node?
	

func remove_effect() -> void:
	pass 
## maybe should set a timer to remove condition or maybe the condition should 
## take care of this themselves and it just gets reapplied 
