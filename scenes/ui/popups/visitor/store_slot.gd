class_name StoreSlot
extends PanelContainer
@onready var badge: Badge = $Wrapper/Badge
@onready var wrapper: Control = $Wrapper
@onready var purchase_popup: Node2D = %PurchasePopup

var item: Node2D
var cost: int = 0
var bought: bool = false
var enabled: bool = true

func _ready() -> void:
	purchase_popup.visible = false

func _process(delta: float) -> void:
	if not bought:
		if Power.current_power < cost:
			disable_slot()
		else:
			enable_slot()

func set_item(node: Node2D, cost: int) -> void:
	badge.set_value(cost)
	item = node
	self.cost = cost
	wrapper.add_child(node)
	wrapper.move_child(node,0)
	if node is Hamster: # add node building and module
		node.draggable_component.draggable = false
	node.z_index = 0
	if node is Hamster:
		node.hide_bars()
	item.position = size * 0.5

func buy_item() -> void:
	#TODO ADD to where it should go hamster -> cage building/module -> inventory
	wrapper.remove_child(item)
	Power.current_power -= cost
	bought = true
	disable_slot()

func disable_slot() -> void:
	self.modulate = Color.GRAY
	badge.modulate.a = 0
	purchase_popup.visible = false
	enabled = false

func enable_slot() -> void:
	self.modulate = Color.WHITE

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("left_mouse") and event.pressed:
		purchase_popup.visible = not purchase_popup.visible 

func _on_button_pressed() -> void:
	buy_item()

func _on_button_2_pressed() -> void:
	purchase_popup.visible = false
