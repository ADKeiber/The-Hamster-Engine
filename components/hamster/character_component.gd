extends CharacterBody2D


@export var interactor : InteractorComponent
@export var hamster : Hamster
var target_pos : Vector2
var move : bool = false
const SPEED = 0.1
const ARRIVAL_DISTANCE = 5
enum State {IDLE, WANDER}


func _physics_process(delta: float) -> void:
	if interactor.interactable is CageInteractableComponent:
		if move == false:
			target_pos = Vector2(
			randf_range(interactor.interactable.start_pos.x, interactor.interactable.end_pos.x) - 20, 
			randf_range(interactor.interactable.start_pos.y, interactor.interactable.end_pos.y) - 20)
			move = true
		if move == true:
			var direction = global_position.direction_to(target_pos)
			velocity = direction * SPEED
			clamp(velocity.x, 0, .1)
			clamp(velocity.y, 0, .1)
			print(velocity, target_pos)
			move_and_slide()
			hamster.global_position = self.global_position
			if global_position.distance_to(target_pos) < ARRIVAL_DISTANCE:
				velocity = Vector2.ZERO
				move = false
				print("Target reached!")
		
