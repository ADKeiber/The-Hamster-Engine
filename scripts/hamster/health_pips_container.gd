extends HBoxContainer
signal death

@onready var health_pip_scene = preload("res://scenes/hamster/health_pip.tscn")
@onready var hamster : HamsterUI = $".."
@onready var max_health : int 
@onready var current_health : int

# Creates health pips as children
func  setup_health() -> void:
	max_health = hamster.stats.health
	current_health = max_health
	for i in max_health:
		var heath_pip = health_pip_scene.instantiate()
		add_child(heath_pip)

# Clears a health pip when damaged
func take_damage() -> void:
	current_health -= 1
	get_child(0).queue_free()
	if current_health == 0:
		death.emit()


	
