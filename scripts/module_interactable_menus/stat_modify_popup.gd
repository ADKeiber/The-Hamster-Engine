class_name StatModifyPopup
extends PopupPanel

signal stat_selected(stat_type:int) #update to be enum
var hamster_ui: HamsterUI
var option_selected: bool = false

func _ready() -> void:
	print(self.popup_window)
	print(self.visible)

func set_hamster(hamster: HamsterUI) -> void:
	hamster_ui = hamster

func _on_speed_pressed() -> void:
	hamster_ui.increase_stat(1,1)
	option_selected = true
	self.visible = false
	stat_selected.emit(1)
	$Click.play()
	get_tree().paused = false

func _on_stamina_pressed() -> void:
	hamster_ui.increase_stat(0,1)
	option_selected = true
	self.visible = false
	stat_selected.emit(0)
	$Click.play()
	get_tree().paused = false

func _on_health_pressed() -> void:
	hamster_ui.increase_stat(2, 1)
	option_selected = true
	self.visible = false
	stat_selected.emit(2)
	get_tree().paused = false


func _on_popup_hide() -> void:
	if option_selected:
		option_selected = false
		return
	hamster_ui.visible = true
	GScript.complete_module_interaction.emit(hamster_ui)
	
	$Click.play()
