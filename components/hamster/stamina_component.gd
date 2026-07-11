class_name StaminaComponent
extends Node

@export var stats: HamsterStatsComponent
var current_stamina: int

signal stamina_changed(current: int, max: int)

func _ready():
	current_stamina = get_max_stamina()
	stamina_changed.emit(current_stamina, get_max_stamina())
	stats.stat_changed.connect(_on_stat_changed)

func set_stamina(value: int) -> void:
	current_stamina = clampi(value, 0, get_max_stamina())
	stamina_changed.emit(current_stamina, get_max_stamina())

func use_stamina(amount: int) -> bool:
	if current_stamina < amount:
		return false
	set_stamina(current_stamina - amount)
	return true

func rest(amount: int) -> bool:
	if current_stamina == get_max_stamina():
		return false
	set_stamina(current_stamina + amount)
	return true

func _on_stat_changed(stat: HamsterStatsComponent.StatType, old_value: int, new_value: int):
	if stat == HamsterStatsComponent.StatType.MAX_STAMINA:
		set_stamina(min(current_stamina, int(new_value)))

func get_max_stamina() -> int:
	return stats.get_stat(HamsterStatsComponent.StatType.MAX_STAMINA)
