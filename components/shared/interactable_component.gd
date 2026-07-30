class_name InteractableComponent
extends Node2D


signal on 
signal off

@export var area : Area2D
var hamster : Hamster
@export var locked_in : bool
var occupied = false


func _on_child_entered_tree(node: Node) -> void:
	if node is Hamster:
		hamster = node

func _on_child_exiting_tree(node: Node) -> void:
	if node is Hamster:
		hamster = null

func entered() -> void:
	on.emit()
	occupied = true
	if locked_in == true:
		hamster.draggable_component.draggable = false
	print("entered")

func exited() -> void: #when hamster is removed
	off.emit()
	occupied = false
	print("exited")
