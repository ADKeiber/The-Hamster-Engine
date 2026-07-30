class_name Condition
extends Resource

@export var name: String
@export_multiline var description: String
var hamster: Hamster

func apply(hamster: Hamster) -> void:
	pass
func remove() -> void:
	pass
func tick() -> void:
	pass
