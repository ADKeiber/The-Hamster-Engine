class_name ToxicResilienceEffect extends GlobalEffect

@export var applied_trait: TraitResource
@export var amt_to_give: int = 5

func apply_effect() -> void:
	if not applied:
		var hamsters_with_traits: Dictionary[Hamster, bool]
		if amt_to_give >= Hamsters.hamsters.size():
				for hamster in  Hamsters.hamsters:
					hamsters_with_traits[hamster] = true
		else:
			for i in range(amt_to_give):
				var next_hamster:Hamster = Hamsters.get_random_hamster()
				while not hamsters_with_traits.has(next_hamster): ## This will trigger if a hamster hasn't been added to damage
					next_hamster = Hamsters.get_random_hamster()
				hamsters_with_traits[next_hamster] = true
		## NOTE THat this will apply the trait to hamsters that might already have it
		for hamster in hamsters_with_traits:
			hamster.add_trait(applied_trait)
		applied = true

func remove_effect() -> void:
	pass ## nothing to really do... could possibly remove the trait from the hamster... thats a later decision
