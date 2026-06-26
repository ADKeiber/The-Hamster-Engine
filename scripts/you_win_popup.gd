class_name YouWinPopup
extends PanelContainer

func _ready() -> void:
	GScript.win_game.connect(_win_game)

func _on_button_pressed() -> void:
	GScript.restart_game.emit()

func _win_game() -> void:
	self.visible = true
