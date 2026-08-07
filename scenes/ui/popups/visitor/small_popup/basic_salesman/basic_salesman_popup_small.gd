class_name BasicSalesmanPopupSmall
extends Control

@onready var time_left_label: Label = %TimeLeftLabel
@onready var simple_dialogue: RichTextLabel = %SimpleDialogue
@onready var visitor_name: RichTextLabel = %VisitorName
@onready var panel_container: PanelContainer = $PanelContainer
@onready var embedded_holder: PanelContainer = %EmbeddedHolder
@onready var collision_shape_2d: CollisionShape2D = $ClickableArea/CollisionShape2D
@onready var speech_bubble_entry: TextureRect = %SpeechBubbleEntry
@onready var popup_contents: MarginContainer = %PopupContents
@onready var speech_bubble_entry_point: Node2D = %SpeechBubbleEntryPoint

var visitor: VisitorResource

func set_popup_info(visitor: VisitorResource) -> void:
	self.visitor = visitor
	simple_dialogue.text = visitor.small_information_text
	visitor_name.text = visitor.visitor_name

func set_time(time: String) -> void:
	time_left_label.text = time

func _on_clickable_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("left_mouse"):
		get_viewport().set_input_as_handled()
		get_parent().open_large_popup.emit(visitor)

func entry_as_global() -> Vector2:
	return speech_bubble_entry_point.global_position
