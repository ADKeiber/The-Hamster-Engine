extends Node2D
class_name InteractableComponent

signal on 
signal off

@export var area : Area2D
var hamster : Hamster
@export var locked_in : bool
var temp_hamster : Hamster
var occupied = false

func _ready() -> void:
	area.area_entered.connect(self.area_entered)
	area.area_exited.connect(self.area_exited)

func area_entered(hamster_area : Area2D) -> void:


#reaparent hamster
func check_hamster(draggable_component:DraggableComponent) -> void:

func reparent_hamster() -> void:



func drag_out(draggable_component:DraggableComponent) -> void:
	power_off()

func power_off() -> void: #when hamster is removed
	temp_hamster = hamster
	
	off.emit()
	print("power off")

func drop_when_occupied(draggable_component:DraggableComponent) -> void:
	draggable_component.failed_to_drop()
	draggable_component.drag_ended.disconnect(drop_when_occupied)
