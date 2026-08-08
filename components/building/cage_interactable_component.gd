extends InteractableComponent
class_name CageInteractableComponent

var hamsters : Array 
@export var cage_area : Area2D
@export var collision_shape : CollisionShape2D
var size : Vector2
var start_pos
var end_pos
var cage_hovered : bool

func _ready() -> void:
	var half : Vector2 = collision_shape.shape.extents
	start_pos = collision_shape.global_position - half
	end_pos = collision_shape.global_position + half
	print(start_pos, end_pos)
	cage_area.mouse_entered.connect(mouse_entered)
	cage_area.mouse_exited.connect(mouse_exited)




func entered(hamster : Hamster) -> void:
	on.emit()
	condition = Rest.new()
	hamsters.append(hamster)
	hamster.add_condition(condition, self)
	print(hamsters)

	if locked_in == true:
		hamster.draggable_component.draggable = false
	print("entered")

func exited(hamster : Hamster) -> void: #when hamster is removed
	off.emit()
	var leaver = hamsters.find(hamster)
	hamsters.remove_at(leaver)
	var rem_con = hamster.condition_component.conditions.find(Rest)
	hamster.condition_component.conditions.remove_at(rem_con)

	
	print(hamsters)
	print("exited")


func mouse_entered() -> void:
	cage_hovered = true


func mouse_exited() -> void:
	cage_hovered = false
