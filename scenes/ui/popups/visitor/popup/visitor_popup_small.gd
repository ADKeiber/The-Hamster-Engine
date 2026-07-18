class_name VisitorPopupSmall
extends Control

@onready var time_left_label: Label = %TimeLeftLabel
@onready var simple_dialogue: RichTextLabel = %SimpleDialogue
@onready var visitor_name: RichTextLabel = %VisitorName
@onready var panel_container: PanelContainer = $PanelContainer
@onready var embedded_holder: PanelContainer = %EmbeddedHolder
@onready var collision_shape_2d: CollisionShape2D = $ClickableArea/CollisionShape2D

var visitor: VisitorResource
var entry_offset: Vector2 = Vector2(10,1)

func set_popup_info(visitor: VisitorResource) -> void:
	self.visitor = visitor
	simple_dialogue.text = visitor.small_information_text
	if visitor.embedded_small_popup != null:
		var dynamic_popup_portion := visitor.embedded_small_popup.instantiate()
		embedded_holder.add_child(dynamic_popup_portion)
	visitor_name.text = visitor.visitor_name
	await get_tree().process_frame
	collision_shape_2d.shape.size = panel_container.size

func set_time(time: String) -> void:
	time_left_label.text = time

func _on_clickable_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("left_mouse"):
		get_viewport().set_input_as_handled()
		get_parent().open_large_popup.emit(visitor)
