class_name VisitorPopupSmall
extends Control

@export var timer: Timer # use 
@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@onready var popup_contents: MarginContainer = %PopupContents
@onready var clickable_area: Area2D = %ClickableArea
@onready var collision_shape: CollisionShape2D = %ClickableArea/CollisionShape2D
@onready var time_left_label: Label = %TimeLeftLabel
@onready var simple_dialogue: RichTextLabel = %SimpleDialogue
@onready var visitor_name: RichTextLabel = %VisitorName
@onready var speech_bubble_entry: TextureRect = %SpeechBubbleEntry
@onready var panel_container: PanelContainer = $PanelContainer
@onready var embedded_holder: PanelContainer = %EmbeddedHolder
@onready var collision_shape_2d: CollisionShape2D = $ClickableArea/CollisionShape2D

var visitor: VisitorResource
var entry_offset: Vector2 = Vector2(10,1)

func _process(delta: float) -> void:
	time_left_label.text = format_timer(round(get_parent().timer.time_left))

func set_popup_info(visitor: VisitorResource) -> void:
	self.visitor = visitor
	time_left_label.text = format_timer(visitor.time_to_complete)
	simple_dialogue.text = visitor.small_information_text
	if visitor.embedded_small_popup != null:
		var dynamic_popup_portion := visitor.embedded_small_popup.instantiate()
		#dynamic_popup_portion.setup_popup(visitor)
		embedded_holder.add_child(dynamic_popup_portion)
	visitor_name.text = visitor.visitor_name
	await get_tree().process_frame
	print(visitor.sprite.get_size())
	position.y = visitor.waiting_position.y - (panel_container.size.y/2.0) - speech_bubble_entry.size.y - 15 #IDK man... use something to determine where to anchor this
	speech_bubble_entry.position = panel_container.position + panel_container.size - entry_offset
	speech_bubble_entry.position.x -= speech_bubble_entry.size.x
	collision_shape_2d.shape.size = panel_container.size

func format_timer(minutes: float) -> String:
	var total_seconds := int(minutes * 60.0)
	var mins := total_seconds / 60
	var secs := total_seconds % 60
	return "%d:%02d" % [mins, secs]

func _on_clickable_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("left_mouse"):
		get_parent().switch_popup.emit()
