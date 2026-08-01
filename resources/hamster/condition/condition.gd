class_name Condition
extends Resource

@export var name: String
@export_multiline var description: String
var hamster: Hamster
var origin: Node
func apply(hamster: Hamster, origin: Node) -> void:
	pass
func remove() -> void:
	pass
func handle_event(event: Event) -> void:
	pass
