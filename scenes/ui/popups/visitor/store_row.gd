class_name StoreRow
extends HBoxContainer

@export var items_for_sale: Array[Node2D] = []

@onready var slots: HBoxContainer = %Slots
@onready var row_name_field: RichTextLabel = %RowNameField

var row_name: String
var num_of_slots: int
var items: Array[Node2D]
const STORE_SLOT = preload("uid://c0nbyexsiw7jv")
func _ready() -> void:
	set_row_without_items()
	set_items()

func store_visitor(row_name: String, num_of_slots: int, items: Array[Node2D]) -> void:
	self.row_name = row_name
	self.num_of_slots = num_of_slots
	self.items = items

func set_row_without_items() -> void:
	if row_name == null or num_of_slots == null or items == null:
		return
	row_name_field.text = row_name
	for i in range(num_of_slots):
		var margin_container := MarginContainer.new()
		margin_container.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
		var slot = STORE_SLOT.instantiate()
		margin_container.add_theme_constant_override("margin_right", 15)
		margin_container.add_child(slot)
		slots.add_child(margin_container)

func set_items() -> void:
	var i: int = 0
	for slot in slots.get_children():
		if i < items.size():
			var slot_container: StoreSlot = slot.get_child(0)
			slot_container.set_item(items[i], randi_range(1,300)) # need to get cost somehow
			i += 1
