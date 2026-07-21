class_name EmbeddedBasicStoreLarge extends VBoxContainer

const HAMSTER = preload("res://scenes/hamster/hamster.tscn")
const STORE_ROW = preload("uid://byea7dq2prjf4")

var visitor: StoreVisitor

func setup_popup(visitor_resource: VisitorResource) -> void:
	self.visitor = visitor_resource as StoreVisitor
	for i in range(visitor.type_of_item_by_row.size()):
		var row_num = i + 1
		var margin_container := MarginContainer.new()
		margin_container.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
		var row = STORE_ROW.instantiate()
		var items_in_row: Array[Node2D] = get_random_items(visitor.amt_in_row[i], visitor.type_of_item_by_row[row_num])
		row.store_visitor(visitor.item_type_to_string(visitor.type_of_item_by_row[row_num]),  visitor.amt_in_row[i],items_in_row)
		margin_container.add_theme_constant_override("margin_top", 10)
		margin_container.add_child(row)
		self.add_child(margin_container)

## just gets the first one for now!
func get_random_items(amt: int, type: StoreVisitor.ItemTypes) -> Array[Node2D]:
	var items: Array[Node2D] = []
	match type: # Its random but we will need to give each weight later
		StoreVisitor.ItemTypes.BUILDING:
			for i in range(amt):
				var index:int = randi_range(0, visitor.possible_buildings.size() - 1)
				#instantiate a building
		StoreVisitor.ItemTypes.HAMSTER:
			for i in range(amt):
				var index:int = randi_range(0, visitor.possible_hamsters.size() - 1)
				var hamster: Hamster = HAMSTER.instantiate() # need to pass in resource
				items.append(hamster)
		StoreVisitor.ItemTypes.MODULE:
			for i in range(amt):
				var index:int = randi_range(0, visitor.possible_modules.size() - 1)
	return items
