class_name HealthComponent
extends Node

@export var stats: HamsterStatsComponent
var current_health: int

signal health_changed(current: int, max: int)

func _ready() -> void:
	current_health = get_max_health()
	health_changed.emit(current_health, get_max_health())
	stats.stat_changed.connect(_on_stat_changed)

func set_health(value: int) -> void:
	current_health = clampi(value, 0, get_max_health())
	health_changed.emit(current_health, get_max_health())
	if current_health == 0:
		die()

func take_damage(amount: int) -> bool:
	if current_health == 0:
		return false
	set_health(current_health - amount)
	return true

func heal(amount: int) -> bool:
	if current_health == get_max_health():
		return false
	set_health(current_health + amount)
	return true

func _on_stat_changed(stat: HamsterStatsComponent.StatType, old_value: int, new_value: int) -> void:
	if stat == HamsterStatsComponent.StatType.MAX_HEALTH:
		set_health(min(current_health, new_value))

func get_max_health() -> int:
	return stats.get_stat(HamsterStatsComponent.StatType.MAX_HEALTH)

func die() -> void:
	# TODO: Play death animation, notify other systems, etc.
	pass
