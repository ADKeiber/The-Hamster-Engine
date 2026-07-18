class_name AnimationComponent
extends AnimatedSprite2D

const ANIMATIONS := {
	AnimationState.IDLE: "idle",
	AnimationState.RUNNING: "run",
	AnimationState.INTERACTING: "interacting",
	AnimationState.BUILT: "built",
	AnimationState.OPENING: "opening",
	AnimationState.CLOSING: "closing",
	AnimationState.WALKING: "walking",
	AnimationState.KNOCKING: "knocking",
	AnimationState.EXCLAMATION: "exclamation"
}

enum AnimationState {IDLE, RUNNING, WALKING, INTERACTING, BUILT, 
	OPENING, CLOSING, KNOCKING, EXCLAMATION #DOOR
} 
#NOTE these are all possible states for all animations :) Add them as required

func update_animation(newState: AnimationState) -> void:
	var animation_name: String = ANIMATIONS[newState]
	if sprite_frames.has_animation(animation_name):
		play(animation_name)
		
func play_animation_once_and_stop(animation_to_play: AnimationState) -> void:
	var animation_name: String = ANIMATIONS[animation_to_play]
	sprite_frames.set_animation_loop(animation_name, false)
	if not animation_finished.is_connected(_on_animation_finished_paused):
		animation_finished.connect(_on_animation_finished_paused, CONNECT_ONE_SHOT)
	play(animation_name)

func invisible() -> void:
	self.modulate.a = 0

func visible() -> void:
	self.modulate.a = 1

func _on_animation_finished_paused() -> void:
	pause()


func _on_animation_finished() -> void:
	pass # Replace with function body.
