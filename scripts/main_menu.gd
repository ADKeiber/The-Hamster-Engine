extends Control



func _ready() -> void:
	get_tree().paused = true
	%"Hamster Wheel".power_wheel()


func _on_start_game_pressed() -> void:
	self.hide()
	get_tree().paused = false
