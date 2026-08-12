class_name PethVisitor
extends ObjectVisitorResource

func setup() -> void:
	Visitor.condition_added.connect(check_condition)

func check_condition(hamster:Hamster, condition: Condition) -> void:
	if condition is Burn:
		print("BURN was added to a hamster... Failed quest")
		leave.emit()

func complete() -> void:
	print("You completed it!") # should probably add success reward

func fail() -> void:
	print("You failed the objective!") # should probably add fail reward
