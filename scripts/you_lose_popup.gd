class_name YouLosePopup
extends PanelContainer

func _ready() -> void:
	GScript.lose_game.connect(_lose_game)

func _on_button_pressed() -> void:
	GScript.restart_game.emit()

func _lose_game() -> void:
	self.visible = true
	GScript.close_popups.emit()
