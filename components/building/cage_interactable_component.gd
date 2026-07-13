extends InteractableComponent
class_name CageInteractableComponent

var hamsters : Array 
@export var collision_shape : CollisionShape2D
var size : Vector2
var start_pos
var end_pos

func _ready() -> void:
	var rect = collision_shape.shape.get_rect()
	start_pos = collision_shape.global_position - collision_shape.position
	end_pos = rect.end + collision_shape.global_position
	print(start_pos, end_pos)
	

func _on_child_entered_tree(node: Node) -> void:
	if node is Hamster:
		hamsters.append(node)
		print(hamsters)

func _on_child_exiting_tree(node: Node) -> void:
	if node is Hamster:
		var leaver = hamsters.find(node)
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
