extends Node

var hamsters: Array[Hamster] ## Current hamsters in the game

func add_hamster(hamster: Hamster) -> void:
	hamsters.append(hamster)
	hamster.condition_component.condition_added.connect(_on_hamster_condition_added) ## Looks 

func remove_hamster(hamster: Hamster) -> void:
	hamsters.erase(hamster)

func get_random_hamster() -> Hamster:
	return hamsters[randi_range(0, hamsters.size() - 1)]

func _on_hamster_condition_added(hamster: Hamster, condition: Condition) -> void:
	Visitor.condition_added.emit(hamster, condition)
