class_name BasicStoreVisitor extends VisitorResource

@export var type_of_item_by_row: Dictionary[int, ItemTypes] ## this tells us the type of item it is in each row. The key == row number

@export var amt_in_row: Array[int] ## index is the row value is the amount
@export var possible_buildings: Array[BuildingResource]
@export var possible_hamsters: Array[HamsterStatsResource]
@export var possible_modules: Array[ModuleResource]
#@export var effects: #TODO ADD LATER... ADD THE POSSIBLITY TO ADD EFFECTS

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
	
