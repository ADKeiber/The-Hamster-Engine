extends Node2D
class_name InteractableComponent

signal on 
signal off


@export var area : Area2D
var hamster : Hamster
@export var locked_in : bool
var occupied = false

func _ready() -> void:
	area.area_entered.connect(area_entered)
	area.area_exited.connect(area_exited)

	
func area_entered(hamster_area : Area2D) -> void:
	if occupied == false:
		hamster = hamster_area.get_parent()
		if hamster.draggable_component.drag_ended.is_connected(reparent_hamster):
			hamster.draggable_component.drag_ended.disconnect(reparent_hamster)
		hamster.draggable_component.drag_ended.connect(reparent_hamster)
		
	if area.area_exited.is_connected(area_exited):
		area.area_exited.disconnect(area_exited)
	area.area_exited.connect(area_exited)
	#else: hamster.draggable_component.failed_to_drop()

func area_exited(hamster_area : Area2D) -> void:
	if hamster_area.get_parent() is Hamster:
		if hamster_area.get_parent().draggable_component.drag_ended.is_connected(reparent_hamster):
			hamster_area.get_parent().draggable_component.drag_ended.disconnect(reparent_hamster)




func reparent_hamster() -> void:
	hamster.reparent(self)
	hamster.invisible()
	hamster.global_position = self.global_position
	on.emit()
	occupied = true
	#get_parent().building_resource.interact(hamster)
	if locked_in == false:
		if hamster.draggable_component.drag_started.is_connected(power_off):
			hamster.draggable_component.drag_started.disconnect(power_off)
		hamster.draggable_component.drag_started.connect(power_off)
	elif locked_in == true:
		hamster.draggable_component.draggable = false
	

func power_off() -> void:
	off.emit()
	hamster.visible()
	occupied = false
	if area.area_exited.is_connected(area_exited):
		area.area_exited.disconnect(area_exited)
		
