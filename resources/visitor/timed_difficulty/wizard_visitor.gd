class_name WizardVisitor extends TimedDifficulty

func apply_difficulty(node:Node) -> void:
	effect.apply_effect(node)

func remove_difficulty() -> void:
	effect.remove_effect()

func give_reward() -> void:
	print("Reward given!")
