class_name Hamster 
extends CharacterBody2D

const BURN_CONDITION = preload("uid://gcxqiowkjugl")
const MAGICALLY_ENHANCED_CONDITION = preload("uid://bt1lfv6w8tuxw")
const REST_CONDITION = preload("uid://cbfcjl0pgym4l")

@onready var draggable_component: DraggableComponent = $DraggableComponent
@onready var audio_component: AudioComponent = $AudioComponent
@onready var hamster_stats_component: HamsterStatsComponent = $HamsterStatsComponent
@onready var animation_component: AnimationComponent = $AnimationComponent
@onready var traits_component: TraitsComponent = $TraitsComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var hamster_type_component: HamsterTypeComponent = $HamsterTypeComponent
@onready var stamina_component: StaminaComponent = $StaminaComponent
@onready var condition_component: ConditionComponent = $ConditionComponent
@onready var stats: HamsterStatsResource

@onready var timer: Timer = $Timer
@onready var health_bar: ProgressBar = %HealthBar
@onready var stamina_bar: ProgressBar = %StaminaBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#hamster_stats_component.set_stats(stats)
	connect_stats()

#func setup_hamster(new_stats: HamsterStatsResource) -> void:
	#stats = new_stats
	#connect_stats()

func connect_stats() -> void:
	stats = hamster_stats_component.get_stats()
	#connect stat information to other components
	traits_component.stats_component = hamster_stats_component
	hamster_type_component.stats_component = hamster_stats_component
	activate_traits_and_type()
	hamster_type_component.stats_component = hamster_stats_component
	animation_component.set_sprite_frames(stats.sprite_frames)
	animation_component.update_animation(AnimationComponent.AnimationState.IDLE)
	health_component.health_changed.connect(update_health_bar)
	stamina_component.stamina_changed.connect(update_stamina_bar)
	var health: int = hamster_stats_component.get_stat(HamsterStatsComponent.StatType.MAX_HEALTH)
	var stamina: int = hamster_stats_component.get_stat(HamsterStatsComponent.StatType.MAX_STAMINA)
	update_health_bar(health, health)
	update_stamina_bar(stamina,stamina)
	audio_component.set_library(stats.audio_library)
	print(hamster_stats_component.get_stats().to_string())
	#stamina_bar.visible = false
	#health_bar.visible = false

func update_health_bar(current: int, max: int) -> void:
	health_bar.max_value = max
	health_bar.value = current

func update_stamina_bar(current: int, max: int) -> void:
	stamina_bar.max_value = max
	stamina_bar.value = current

func activate_traits_and_type() -> void:
	traits_component.on_event(TraitEvent.new(TraitEvent.EventType.CREATED, self, {}))
	hamster_type_component.on_event(TraitEvent.new(TraitEvent.EventType.CREATED, self, {}))

func hide_bars() -> void:
	stamina_bar.visible = false
	health_bar.visible = false

@onready var interactor : InteractorComponent = $InteractorComponent
var target_pos : Vector2
var move : bool = false
const MAX_SPEED = 0.1
const SPEED = 0.1
const ARRIVAL_DISTANCE = 1
enum State {IDLE, WANDER, DRAGGED}
var current_state : State = State.DRAGGED
var timer_start = false

func _physics_process(delta: float) -> void:
	if draggable_component.dragging == true:
		$CharacterCollision.disabled = true
		current_state = State.DRAGGED
	
	if interactor.interactable is CageInteractableComponent:
			
		match current_state:
			State.DRAGGED:
				$CharacterCollision.disabled = true
				if draggable_component.dragging == false:
					current_state = State.IDLE
				timer_start = false
				return
			
			State.IDLE:
				$CharacterCollision.disabled = false
				if timer_start == true:
					return
				pick_new_target()
				timer_start = true
			
			State.WANDER:
				
				move_toward_target(delta)

func pick_new_target() -> void:
	$Timer.start(randf_range(1, 3))
	await $Timer.timeout
	if current_state == State.IDLE:
		var cage = interactor.interactable
		target_pos = Vector2(
					randf_range(cage.start_pos.x, cage.end_pos.x), 
					randf_range(cage.start_pos.y, cage.end_pos.y))
		print(target_pos)
		timer_start = false
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
		if collision.get_collider() is Hamster:
			var body = collision.get_collider()
			if global_position.x < body.global_position.x:
				if global_position.y < body.global_position.y:
					target_pos = global_position + Vector2(-20, -20)
				if global_position.y > body.global_position.y:
					target_pos = global_position + Vector2(-20, 20)
			elif global_position.x > body.global_position.x:
				if global_position.y < body.global_position.y:
					target_pos = global_position + Vector2(20, -20)
				if global_position.y > body.global_position.y:
					target_pos = global_position + Vector2(20, 20)
		else:
			current_state = State.IDLE
