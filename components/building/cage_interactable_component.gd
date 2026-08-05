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

func _on_child_entered_tree(node: Node) -> void:
	if node is Hamster:
		hamsters.append(node)
		node.add_condition(condition, self)
		print(hamsters)

func _on_child_exiting_tree(node: Node) -> void:
	if node is Hamster:
		var leaver = hamsters.find(node)
		node.remove_condition(condition)
		hamsters.remove_at(leaver)
		print(hamsters)

func entered() -> void:
	on.emit()
	if locked_in == true:
		hamster.draggable_component.draggable = false
	print("entered")

func exited() -> void: #when hamster is removed
	off.emit()
	print("exited")


func mouse_entered() -> void:
	cage_hovered = true


func mouse_exited() -> void:
	cage_hovered = false
