extends Node2D
class_name InteractableComponent

signal on
signal off

@export var area : Area2D
var hamster : Hamster
@export var locked_in : bool
var occupied : bool = false
var locked_in_time : float

func _on_child_entered_tree(node: Node) -> void:
	if node is Hamster:
		hamster = node
		on.emit()
		occupied = true
		if locked_in == true:
			hamster.draggable_component.draggable = false
		print("entered")

func _on_child_exiting_tree(node: Node) -> void:
	if node is Hamster:
		hamster = null
		off.emit()
		occupied = false
		print("exited")
