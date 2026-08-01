extends Node

var hamsters: Array[Hamster] ## Current hamsters in the game

func add_hamster(hamster: Hamster) -> void:
	hamsters.append(hamster)

func remove_hamster(hamster: Hamster) -> void:
	hamsters.erase(hamster)

func get_random_hamster() -> Hamster:
	return hamsters[randi_range(0, hamsters.size() - 1)]
