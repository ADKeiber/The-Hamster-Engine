class_name InteractableComponent
extends Node2D


signal on
signal off

@export var area : Area2D
var hamster : Hamster
@export var locked_in : bool
var occupied : bool = false
var locked_in_time : float
var condition : Condition

func _on_child_entered_tree(node: Node) -> void:
	if node is Hamster:
		hamster = node
		on.emit()
		occupied = true
		hamster.add_condition(condition, self)
		if locked_in == true:
			hamster.draggable_component.draggable = false
		print("entered")

func _on_child_exiting_tree(node: Node) -> void:
	if node is Hamster:
		hamster.remove_condition(condition)
		hamster = null
		off.emit()
		occupied = false
		print("exited")
