class_name Hamster extends Node2D

const BURN_CONDITION = preload("uid://gcxqiowkjugl")
const MAGICALLY_ENHANCED_CONDITION = preload("uid://bt1lfv6w8tuxw")
const REST_CONDITION = preload("uid://cbfcjl0pgym4l")
@export var stats: HamsterStatsResource

@onready var draggable_component: DraggableComponent = $DraggableComponent
@onready var audio_component: AudioComponent = $AudioComponent
@onready var hamster_stats_component: HamsterStatsComponent = $HamsterStatsComponent
@onready var animation_component: AnimationComponent = $AnimationComponent
@onready var traits_component: TraitsComponent = $TraitsComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var hamster_type_component: HamsterTypeComponent = $HamsterTypeComponent
@onready var stamina_component: StaminaComponent = $StaminaComponent
@onready var condition_component: ConditionComponent = $ConditionComponent


@onready var timer: Timer = $Timer
@onready var health_bar: ProgressBar = %HealthBar
@onready var stamina_bar: ProgressBar = %StaminaBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#hamster_stats_component.set_stats(stats)
	connect_stats()

func connect_stats() -> void:
	var stats: HamsterStatsResource = hamster_stats_component.get_stats()
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

func update_health_bar(current: int, max: int) -> void:
	health_bar.max_value = max
	health_bar.value = current

func update_stamina_bar(current: int, max: int) -> void:
	stamina_bar.max_value = max
	stamina_bar.value = current

func activate_traits_and_type() -> void:
	traits_component.on_event(TraitEvent.new(TraitEvent.EventType.CREATED, self, {}))
	hamster_type_component.on_event(TraitEvent.new(TraitEvent.EventType.CREATED, self, {}))
