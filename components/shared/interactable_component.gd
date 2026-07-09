extends Node2D
class_name Interactable_Component

signal on (hamster : Hamster)
signal off


@export var area : Area2D
var hamster : Hamster
@export var locked_in : bool


func _ready() -> void:
	area.area_entered.connect(area_entered)
	area.area_exited.connect(area_exited)
	
func area_entered(hamster_area : Area2D) -> void:
	if hamster_area.get_parent() is Hamster:
		hamster = hamster_area.get_parent()
		if hamster.draggable_component.dragging == false:
			reparent_hamster()

func area_exited() -> void:
	hamster = null

func reparent_hamster() -> void:
	hamster.reparent(self)
	hamster.modulate.a = 0
	hamster.global_position = self.global_position
	on.emit()
	get_parent().building_resource.interact(hamster)
	if locked_in == false:
		hamster.draggable_component.drag_started.connect(power_off)
	elif locked_in == true:
		hamster.draggable_component.draggable = false

func power_off() -> void:
	off.emit()
	hamster.drag_started.disconnect()
	hamster.modualte.a = 1
