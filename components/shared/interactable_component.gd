class_name InteractableComponent
extends Node2D


signal on
signal off

@export var area : Area2D
@export var locked_in : bool
var hamster : Hamster
var occupied : bool = false
var locked_in_time : float
var condition : Condition

func entered(_hamster : Hamster) -> void:
	hamster = _hamster
	on.emit()
	occupied = true
	if condition != null:
		hamster.add_condition(condition, self)
	if locked_in == true:
		hamster.draggable_component.draggable = false
	print("entered")

func exited(_hamster : Hamster) -> void:
	if condition != null:
		hamster.remove_condition(condition)
	hamster = null
	off.emit()
	occupied = false
	print("exited")
