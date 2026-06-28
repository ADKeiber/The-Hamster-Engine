extends Node2D
class_name HamsterWheel

@export var sound_active: bool = true
var wheel_on: bool = false

func _ready() -> void:
	$Hamster.hide() #So the hamster isn't visible while wheel is idle

# Starts the animations
func power_wheel() -> void:
	$BaseWheel.play("running")
	$BackgroundWheel.play("running")
	$ForegroundWheel.play("running")
	$Hamster.show()
	$Hamster.play("running")
	if sound_active:
		$RunningSound.play()
	wheel_on = true

	# Stops the animations and rehides hamster
func power_off() -> void:
	$BaseWheel.pause()
	$BackgroundWheel.pause()
	$ForegroundWheel.pause()
	$Hamster.hide()
	$RunningSound.stop()
	wheel_on = false

func damage() -> void:
	$BaseWheel.self_modulate = Color.RED
	$BackgroundWheel.self_modulate = Color.RED
	$ForegroundWheel.self_modulate = Color.RED
	$Hamster.self_modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	$BaseWheel.self_modulate = Color.WHITE
	$BackgroundWheel.self_modulate = Color.WHITE
	$ForegroundWheel.self_modulate = Color.WHITE
	$Hamster.self_modulate = Color.WHITE

#can loop if we want.. decided not to for now
#func _on_running_sound_finished() -> void:
	#if wheel_on && sound_active:
		#$RunningSound.play()
