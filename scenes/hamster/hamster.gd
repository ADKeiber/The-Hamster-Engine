extends Node2D
class_name Hamster

@export var draggable_component : DraggableComponent

func invisible():
	$sprite.self_modulate.a = 0
	
func visible():
	$sprite.self_modulate.a = 1
