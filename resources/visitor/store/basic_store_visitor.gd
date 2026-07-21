class_name BasicStoreVisitor extends VisitorResource

@export var wheel_building: BuildingResource
@export var hamster: HamsterStatsResource
@export var possible_modules: Array[ModuleResource]

enum ItemTypes {BUILDING, HAMSTER, MODULE}

## this will handle the buying functionality.. It puts it in different area depending on 
## what the type is
func buy_item(item: Resource) -> void: #idk the type yet TBH... subject to change
		if item is BuildingResource:
			print("Bought Building")
		elif item is HamsterStatsResource:
			print("Bought Hamster")
		elif item is ModuleResource:
			print("Bought Module")

static func item_type_to_string(item_type: ItemTypes) -> String:
	match item_type:
		ItemTypes.BUILDING:
			return "Building"
		ItemTypes.HAMSTER:
			return "Hamster"
		ItemTypes.MODULE:
			return "Module"
		_:
			return "Unknown"
	
