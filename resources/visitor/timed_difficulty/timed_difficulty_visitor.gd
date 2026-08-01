class_name TimedDifficulty extends VisitorResource

@export var has_reward: bool = true
@export var effect: GlobalEffect
@export var started: bool

func apply_difficulty(node: Node) -> void:
	pass

func remove_difficulty() -> void:
	pass

func give_reward() -> void:
	pass
