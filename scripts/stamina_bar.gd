extends ProgressBar


@onready var hamster : HamsterUI = $".."
var change : float = 0

# Sets stamina based on stat
func _ready() -> void:
	max_value = hamster.stats.stamina * 100
	value = max_value
	
# Changes value in real time
func _process(delta: float) -> void:
	value += change

# Sets the Stamina bar change value
func stamina_change() -> void:
	if hamster.hamster_state == hamster.State.IDLE:
		change = 0
	elif hamster.hamster_state == hamster.State.RUNNING:
		change = - 0.2
	elif hamster.hamster_state == hamster.State.RESTING:
		change = 0.2
