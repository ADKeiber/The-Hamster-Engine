extends ProgressBar
signal damage

@onready var hamster : HamsterUI = $".."
var change : float = 0
var drained : bool
var chance : float


# Sets stamina based on stat
func setup_stamina() -> void:
	max_value = hamster.stats.stamina * 100
	value = max_value
	chance = hamster.stats.chance_to_take_damage


# Changes value in real time
func _process(delta: float) -> void:
	value += change
	stamina_drained()

# Sets the Stamina bar change value
func stamina_change() -> void:
	if hamster.hamster_state == hamster.State.IDLE:
		change = 0
	elif hamster.hamster_state == hamster.State.RUNNING:
		change = - 0.1
	elif hamster.hamster_state == hamster.State.RESTING:
		change = 0.1
	
func stamina_drained() -> void:
	if value == 0:
		if drained == false and hamster.hamster_state == hamster.State.RUNNING:
			$Timer.start()
			drained = true
	if value > 0 or hamster.hamster_state != hamster.State.RUNNING: 
		if drained == true:
			$Timer.stop()
			drained = false
	
	

func _on_timer_timeout() -> void:
	var randnum = randf()
	if randnum <= chance:
		damage.emit()
		print("damage")
	print("timer")
	
	
	
