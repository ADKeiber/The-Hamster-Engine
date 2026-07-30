class_name FoodMutation
extends GlobalEffect

@export var condition: Condition

##NOTE: This one keeps getting applied.. Its not a one and done thing :)
## also this should probably only apply it to hamsters who are in the cage... but 
## we will figure out how to determine that later.. Also thsi is the same script as TaintedCrop...
## Could probably just differentiate on the resource level and not script level
func apply_effect() -> void:
	##Applied tainted food condition to hamsters
	for hamster in Hamsters.hamsters:
		hamster.condition_component.add_condition(condition)
	

func remove_effect() -> void:
	pass 
## maybe should set a timer to remove condition or maybe the condition should 
## take care of this themselves and it just gets reapplied 
