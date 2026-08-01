class_name EmbeddedBasicSalesmanLarge
extends PanelContainer

@onready var hamster_slot: StoreSlot = $Control/HamsterSlot
@onready var wheel_slot: StoreSlot = $Control/WheelSlot
@onready var module_slot: StoreSlot = $Control/ModuleSlot
@onready var module_slot_2: StoreSlot = $Control/ModuleSlot2
@onready var module_slot_3: StoreSlot = $Control/ModuleSlot3
@onready var module_slot_4: StoreSlot = $Control/ModuleSlot4


func setup_popup(visitor: VisitorResource) -> void:
	if not visitor is BasicStoreVisitor:
		return
	
