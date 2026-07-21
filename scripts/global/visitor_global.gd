class_name VisitorGlobal
extends Node

signal pass_time

func set_timer(timer: Timer) -> void:
	timer.timeout.connect(reduce_event_time)

func reduce_event_time() -> void:
	pass_time.emit()
