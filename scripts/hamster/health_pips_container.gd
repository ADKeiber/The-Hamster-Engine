extends HBoxContainer

@onready var health_pip_scene = preload("res://scenes/hamster/health_pip.tscn")
@onready var hamster : HamsterUI = $".."
@onready var max_health : int = hamster.stats.health
@onready var current_health : int = max_health

# Creates health pips as children
func  _ready() -> void:
	for i in max_health:
		var heath_pip = health_pip_scene.instantiate()
		add_child(heath_pip)

# Clears a health pip when damaged
func take_damage() -> void:
	current_health -= 1
	get_child(0).queue_free()
	if current_health == 0:
		death()

func death() -> void: #removes hamster TODO add animation
	hamster.queue_free()
	hamster.picked_up.emit()
