class_name TraitResource extends Resource

@export var name: String
@export var trait_id: int
@export_multiline var description: String
@export_range(1, 3) var rank : int = 1 # 1, 2, or 3
	
func handle_event(event: Event, stats: HamsterStatsComponent ) -> void:
	pass
