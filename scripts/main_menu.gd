class_name MainMenu
extends Control

@onready var base: AnimatedSprite2D = %Base
@onready var layer2: AnimatedSprite2D = %"2ndLayer"
@onready var layer3: AnimatedSprite2D = %"3rdLayer"

var skip_tutorial: bool = false

func _ready() -> void:
	get_tree().paused = true
	%"Hamster Wheel".power_wheel()
	reset_animation()


func _on_start_game_pressed() -> void:
	self.hide()
	#GScript.start_tutorial.emit()
	#get_tree().paused = false
	get_tree().paused = false
	if not skip_tutorial:
		get_parent().start_tutorial.emit()
	$Click.play()

func reset_animation() -> void:
	#again.. needed because otherwise the pipes were disjointed and on different frames
	base.stop()
	layer2.stop()
	layer3.stop()
	base.play()
	layer2.play()
	layer3.play()


func _on_check_box_toggled(toggled_on: bool) -> void:
	skip_tutorial = toggled_on
