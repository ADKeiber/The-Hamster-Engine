extends Node2D

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

#can loop if we want.. decided not to for now
#func _on_running_sound_finished() -> void:
	#if wheel_on && sound_active:
		#$RunningSound.play()
