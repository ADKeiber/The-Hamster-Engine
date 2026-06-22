extends Node2D


func _ready() -> void:
	$Hamster.hide() #So the hamster isn't visible while wheel is idle
	
	# Starts the animations
func power_wheel() -> void:
	$BaseWheel.play("running")
	$BackgroundWheel.play("running")
	$ForegroundWheel.play("running")
	$Hamster.show()
	$Hamster.play("running")
	# Stops the animations and rehides hamster
func power_off() -> void:
	$BaseWheel.pause()
	$BackgroundWheel.pause()
	$ForegroundWheel.pause()
	$Hamster.hide()
