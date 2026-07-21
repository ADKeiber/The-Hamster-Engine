class_name WizardVisitor extends TimedDifficulty

func apply_difficulty() -> void:
	effect.apply_effect()

func remove_difficulty() -> void:
	effect.remove_effect()

func give_reward() -> void:
	print("Reward given!")
