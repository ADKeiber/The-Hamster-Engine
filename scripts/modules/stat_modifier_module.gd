class_name StatModifierModule
extends MachineModule

var remaining_ticks: int
var module_timer: Timer
var bar: ProgressBar
var hamster_ui: HamsterUI

var interactable_menu: StatModifyPopup
const STAT_MODIFY_POPUP = preload("res://scenes/machine/module_interactable_menus/stat_modify_popup.tscn")

func start_module() -> void:
	GScript.hamster_watts_min = GScript.hamster_watts_min + min_power_increase
	module_to_upgrade.interact_power_cost = self.interact_power_cost
	module_to_upgrade.callables.append(interact_with_hamster)

func interact_with_hamster(hamster:HamsterUI, timer: Timer, progress_bar: ProgressBar) -> void:
	hamster.visible = false
	await choose_stat(hamster)
	print("UPGRADED expermintal tank!")
	hamster_ui = hamster
	hamster_ui.hamster_state = HamsterUI.State.RESTING
	hamster_ui.change_states()
	bar = progress_bar
	module_timer = timer
	bar.visible = true
	
	remaining_ticks = self.ticks_to_complete_interaction
	_set_progress_bar()
	module_timer.timeout.connect(_on_timeout)
	module_timer.start(GScript.global_tick_time)

func _on_timeout() -> void:
	print("Timeout!")
	if remaining_ticks > 0:
		bar.value = remaining_ticks
		remaining_ticks -= 1
	else:
		module_timer.stop()
		bar.visible = false
		GScript.complete_module_interaction.emit(hamster_ui)
		hamster_ui.visible = true
		_reset_module()

func _set_progress_bar() -> void:
	bar.min_value = 1
	bar.max_value = ticks_to_complete_interaction
	bar.step = 1
	bar.value = bar.max_value
	bar.show_percentage = false
	bar.indeterminate = false

func _reset_module() -> void:
	remaining_ticks = self.ticks_to_complete_interaction
	module_timer = null
	bar = null
	hamster_ui = null

func choose_stat(hamster: HamsterUI) -> void:
	interactable_menu = STAT_MODIFY_POPUP.instantiate()
	interactable_menu.set_hamster(hamster)
	#interactable_menu.mouse_filter = Control.MOUSE_FILTER_STOP
	hamster.get_parent().add_child(interactable_menu) # should get module slot. Add check
	var parent = hamster.get_parent()
	var center_x = parent.global_position.x + parent.size.x / 2.0
	var x = center_x - interactable_menu.size.x / 2.0
	var y = parent.global_position.y
	hamster.get_tree().paused = true
	interactable_menu.position = Vector2(x, y)
	interactable_menu.visible = true
	hamster.visible = false
	await interactable_menu.stat_selected
