class_name ExperimentalTankModule
extends MachineModule

#this can be triggered when a hamster is dropped into the area 2D...
# make sure to set the hamster variable first.. might need to be a
#hamster_ui instead of stats.. more testing needed
var remaining_ticks: int
var module_timer: Timer
var bar: ProgressBar
var hamster_ui: HamsterUI
func start_module() -> void:
	GScript.hamster_watts_min = GScript.hamster_watts_min + min_power_increase

func interact_with_hamster(hamster:HamsterUI, timer: Timer, progress_bar: ProgressBar) -> void:
	if not callables.is_empty():
		timer.timeout.disconnect(_on_timeout)
		callables[0].call(hamster, timer, progress_bar)
		return # this process can be updated to interact diffrently but this works for here
	hamster_ui = hamster
	bar = progress_bar
	module_timer = timer
	bar.visible = true
	hamster.visible = false
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
		hamster_ui.increase_random_stat(1)
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
	
