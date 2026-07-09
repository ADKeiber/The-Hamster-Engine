class_name HamsterStatsComponent extends Node

@export var _stats: HamsterStatsResource

signal stat_changed(stat: StatType, old_value: int, new_value: int)
signal stats_initialized

enum StatType {MAX_HEALTH, MAX_STAMINA, SPEED, STAMINA_BURN, HEALTH_BURN} # put more here later

func _ready() -> void:
	assert(_stats != null)
	stats_initialized.emit()

func set_stat_value(type: StatType, new_value: int) -> void:
	var old_value: int = get_stat(type)
	match type:
		StatType.MAX_HEALTH:
			_stats.max_health = new_value
		StatType.MAX_STAMINA:
			_stats.max_stamina = new_value
		StatType.SPEED:
			_stats.speed = new_value
	if old_value != new_value:
		stat_changed.emit(type, old_value, new_value)

func get_stat(type:StatType) -> int:
	match type:
		StatType.MAX_HEALTH:
			return _stats.max_health
		StatType.MAX_STAMINA:
			return _stats.max_stamina
		StatType.SPEED:
			return _stats.speed
	return 0

func get_stats() -> HamsterStatsResource:
	return _stats

func set_stats(stats: HamsterStatsResource) -> void:
	_stats = stats
