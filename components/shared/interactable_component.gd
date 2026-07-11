extends Node2D
class_name InteractableComponent

signal on 
signal off


@export var area : Area2D
var hamster : Hamster
@export var locked_in : bool
var occupied = false
var hovering_hamster

func _ready() -> void:
	area.area_entered.connect(self.area_entered)
	area.area_exited.connect(self.area_exited)

func area_entered(hamster_area : Area2D) -> void:
	if occupied == false && hamster_area.get_parent() is Hamster:
		hovering_hamster = hamster_area
		#if hovering_hamster.get_parent().draggable_component.drag_ended.is_connected(self.reparent_hamster):
			#hovering_hamster.get_parent().draggable_component.drag_ended.disconnect(self.reparent_hamster)
		hovering_hamster.get_parent().draggable_component.drag_ended.connect(self.reparent_hamster)


func area_exited(hamster_area : Area2D) -> void:
	if hamster_area != hovering_hamster:
		if hamster_area.get_parent().draggable_component.drag_ended.is_connected(self.reparent_hamster):
			hamster_area.get_parent().draggable_component.drag_ended.disconnect(self.reparent_hamster)


#reaparent hamster
func reparent_hamster() -> void:
	hamster = hovering_hamster.get_parent()
	hamster.reparent(self)
	hamster.animation_component.invisible()
	hamster.global_position = self.global_position
	on.emit()
	occupied = true
	#get_parent().building_resource.interact(hamster) For future building trigger use 
	if locked_in == false:
		if hamster.draggable_component.drag_started.is_connected(self.power_off):
			hamster.draggable_component.drag_started.disconnect(self.power_off)
		hamster.draggable_component.drag_started.connect(self.power_off)
	elif locked_in == true: # lockes hamster into machine
		hamster.draggable_component.draggable = false
	

func power_off() -> void: #when hamster is removed
	off.emit()
	hamster.animation_component.visible()
	occupied = false
	if hamster.draggable_component.drag_started.is_connected(self.power_off):
			hamster.draggable_component.drag_started.disconnect(self.power_off)
