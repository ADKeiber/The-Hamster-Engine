extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BaseWheel.play()
	$BackgroundWheel.play()
	$ForegroundWheel.play()
	$Hamster.play()
	global_position = Vector2(100, 100)
