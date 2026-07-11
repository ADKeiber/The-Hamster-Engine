extends Node2D
class_name InteractableComponent

signal on 
signal off

@export var area : Area2D
var hamster : Hamster
@export var locked_in : bool

func _ready() -> void:
	area.area_entered.connect(self.area_entered)
	area.area_exited.connect(self.area_exited)

func area_entered(hamster_area : Area2D) -> void:
	print(hamster_area.get_parent())
	if hamster != null: # need to check if another hamster 
		print("Hamster is currently using machine!")
		if not hamster_area.get_parent().draggable_component.drag_ended.is_connected(self.drop_when_occupied):
			hamster_area.get_parent().draggable_component.drag_ended.connect(self.drop_when_occupied)
		return
	if hamster_area.get_parent() is Hamster:
		if not hamster_area.get_parent().draggable_component.drag_ended.is_connected(self.reparent_hamster):
			hamster_area.get_parent().draggable_component.drag_ended.connect(self.reparent_hamster)

func area_exited(hamster_area : Area2D) -> void:
	if hamster_area.get_parent().draggable_component.drag_ended.is_connected(self.reparent_hamster):
		hamster_area.get_parent().draggable_component.drag_ended.disconnect(self.reparent_hamster)

#reaparent hamster
func reparent_hamster(draggable_component:DraggableComponent) -> void:
	var possible_hamster := draggable_component.get_parent()
	if not possible_hamster is Hamster:
		return
	if not area.overlaps_area(draggable_component.area):
		return
	if hamster != null: # a hamster is in here!
		draggable_component.failed_to_drop()
		return
	if hamster == null:
		hamster = possible_hamster
		possible_hamster.reparent(self)
		
		if draggable_component.drag_ended.is_connected(drop_when_occupied):
			draggable_component.drag_ended.disconnect(drop_when_occupied)
		hamster.animation_component.invisible()
		hamster.global_position = self.global_position
		hamster.draggable_component.start_drag_location = hamster.global_position
		on.emit()
		if locked_in == false:
			hamster.draggable_component.drag_started.connect(self.drag_out)
		elif locked_in == true: # lockes hamster into machine
			hamster.draggable_component.draggable = false
	print("reparented")

func drag_out(draggable_component:DraggableComponent) -> void:
	hamster.animation_component.visible()
	if hamster.draggable_component.drag_started.is_connected(self.drag_out):
		hamster.draggable_component.drag_started.disconnect(self.drag_out)
	power_off()

func power_off() -> void: #when hamster is removed
	hamster = null
	off.emit()
	print("power off")

func drop_when_occupied(draggable_component:DraggableComponent) -> void:
	draggable_component.failed_to_drop()
	draggable_component.drag_ended.disconnect(drop_when_occupied)

func check_child_type(node, type) -> bool:
	for child in node.get_children():
		if is_instance_of(child, type):
			return true
	return false
