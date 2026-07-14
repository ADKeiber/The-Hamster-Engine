class_name AnimationComponent
extends AnimatedSprite2D


const ANIMATIONS := {
	AnimationState.IDLE: "idle",
	AnimationState.RUNNING: "run",
	AnimationState.INTERACTING: "interacting",
	AnimationState.BUILT: "built"
}

enum AnimationState {IDLE, RUNNING, INTERACTING, BUILT} 
#NOTE these are all possible states for all animations :) Add them as required



func update_animation(newState: AnimationState) -> void:
	var animation_name: String = ANIMATIONS[newState]
	if sprite_frames.has_animation(animation_name):
		play(animation_name)



func invisible() -> void:
	self_modulate.a = 0

func visible() -> void:
	self_modulate.a = 1
