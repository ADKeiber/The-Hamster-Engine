class_name TimedDifficulty extends VisitorResource

@export var has_reward: bool = true
@export var effect: GlobalEffect

func apply_difficulty() -> void:
	pass

func remove_difficulty() -> void:
	pass

func give_reward() -> void:
	pass
