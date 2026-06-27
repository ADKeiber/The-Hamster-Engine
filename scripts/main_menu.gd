class_name MainMenu
extends Control

@onready var base: AnimatedSprite2D = %Base
@onready var layer2: AnimatedSprite2D = %"2ndLayer"
@onready var layer3: AnimatedSprite2D = %"3rdLayer"

func _ready() -> void:
	get_tree().paused = true
	%"Hamster Wheel".power_wheel()
	reset_animation()


func _on_start_game_pressed() -> void:
	self.hide()
	#GScript.start_tutorial.emit()
	get_tree().paused = false

func reset_animation() -> void:
	#again.. needed because otherwise the pipes were disjointed and on different frames
	base.stop()
	layer2.stop()
	layer3.stop()
	base.play()
	layer2.play()
	layer3.play()
