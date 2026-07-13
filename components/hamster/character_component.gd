extends CharacterBody2D
class_name CharacterComponent

@export var interactor : InteractorComponent
@export var hamster : Hamster
@export var draggable : DraggableComponent
var target_pos : Vector2
var move : bool = false
const MAX_SPEED = 0.001
const SPEED = 0.001
const ARRIVAL_DISTANCE = 1
enum State {IDLE, WANDER, DRAGGED}
var current_state : State = State.IDLE

#func _ready() -> void:
	#draggable.drag_ended.connect(reset_velocity)

func _physics_process(delta: float) -> void:
	if interactor.interactable is CageInteractableComponent:
		
		if draggable.dragging == true:
			current_state = State.DRAGGED

			
		match current_state:
			State.DRAGGED:
				$CollisionShape2D.disabled = true
				if draggable.dragging == false:
					current_state = State.IDLE
				return
			
			State.IDLE:
				$CollisionShape2D.disabled = true
				pick_new_target()
			
			State.WANDER:
				$CollisionShape2D.disabled = false
				move_toward_target(delta)
				hamster.global_position = self.global_position


func pick_new_target() -> void:
	var cage = interactor.interactable
	target_pos = Vector2(
				randf_range(cage.start_pos.x, cage.end_pos.x), 
				randf_range(cage.start_pos.y, cage.end_pos.y))
	print(target_pos)
	current_state = State.WANDER

func move_toward_target(delta) -> void:
	if global_position.distance_to(target_pos) < ARRIVAL_DISTANCE:
		current_state = State.IDLE
		print("Target reached!")
		velocity = Vector2.ZERO
		return

	var direction = global_position.direction_to(target_pos)
	var target_velocity = direction * MAX_SPEED
	
	velocity = velocity.move_toward(target_velocity, delta * SPEED)
	
	var collision = move_and_collide(velocity)
	if collision:
		current_state = State.IDLE
