class_name Main
extends Control
@onready var encounter_manager: VisitorManager = $EncounterManager

const BASIC_STORE = preload("uid://d2xunjkruqawl")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var basic_store : VisitorResource = BASIC_STORE.duplicate(true)
	encounter_manager.set_visitor(basic_store)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
