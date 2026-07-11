class_name AnimationComponent
extends Node2D

@export var sprite_frame: SpriteFrames
@onready var animation: AnimatedSprite2D = %Animation

const ANIMATIONS := {
	AnimationState.IDLE: "idle",
	AnimationState.RUNNING: "run",
	AnimationState.INTERACTING: "interacting",
	AnimationState.BUILT: "built"
}

enum AnimationState {IDLE, RUNNING, INTERACTING, BUILT} 
#NOTE these are all possible states for all animations :) Add them as required

func _ready() -> void:
	#await animated_sprite.ready
	animation.set_sprite_frames(sprite_frame)

func update_animation(newState: AnimationState) -> void:
	var animation_name: String = ANIMATIONS[newState]
	if animation.sprite_frames.has_animation(animation_name):
		animation.play(animation_name)

func set_sprite_frames(frames: SpriteFrames) -> void:
	animation.set_sprite_frames(frames)

func invisible() -> void:
	animation.self_modulate.a = 0

func visible() -> void:
	animation.self_modulate.a = 1
