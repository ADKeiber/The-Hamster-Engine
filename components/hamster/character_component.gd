extends CharacterBody2D
class_name CharacterComponent

@export var interactor : InteractorComponent
@export var hamster : Hamster
@export var draggable : DraggableComponent
var target_pos : Vector2
var move : bool = false
const SPEED = 0.05
const ARRIVAL_DISTANCE = 1
enum State {IDLE, WANDER}

#func _ready() -> void:
	#draggable.drag_ended.connect(reset_velocity)

func _physics_process(delta: float) -> void:
	if draggable.dragging == true:
		velocity = Vector2.ZERO
		$CollisionShape2D.disabled = true
		return
	
	if interactor.interactable is CageInteractableComponent:
		if move == false:
			velocity = Vector2.ZERO
			target_pos = Vector2(
			randf_range(interactor.interactable.start_pos.x, interactor.interactable.end_pos.x) - 20, 
			randf_range(interactor.interactable.start_pos.y, interactor.interactable.end_pos.y) - 20)
			move = true
		if move == true:
			$CollisionShape2D.disabled = false
			velocity = Vector2.ZERO
			var direction = global_position.direction_to(target_pos)
			velocity.x = clamp(direction.x * SPEED, - SPEED, SPEED)
			velocity.y = clamp(direction.y * SPEED, - SPEED, SPEED)
			print(velocity, target_pos)
			move_and_slide()
			hamster.global_position = self.global_position
			if global_position.distance_to(target_pos) < ARRIVAL_DISTANCE:
				velocity = Vector2.ZERO
				move = false
				print("Target reached!")
