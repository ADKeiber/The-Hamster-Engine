class_name Test
extends Control

const CONTENT_PADDING := Vector2(0, 0)

@onready var bubble: Control = %Bubble
@onready var vbox: VBoxContainer = %VBoxContainer
@onready var embedded_holder: MarginContainer = %EmbeddedHolder

@onready var clickable_area: Area2D = %ClickableArea
@onready var collision_shape: CollisionShape2D = %ClickableArea/CollisionShape2D

@onready var time_left_label: Label = %TimeLeftLabel
@onready var simple_dialogue: RichTextLabel = %SimpleDialogue
@onready var visitor_name: RichTextLabel = %VisitorName

var visitor: VisitorResource

#
#func set_popup_info(visitor: VisitorResource) -> void:
	#self.visitor = visitor
#
	#time_left_label.text = format_timer(visitor.time_to_complete)
	#simple_dialogue.text = visitor.small_information_text
	#visitor_name.text = visitor.visitor_name
#
	## Remove previous embedded popup
	#for child in embedded_holder.get_children():
		#child.queue_free()
#
	## Add new embedded popup
	#if visitor.embedded_small_popup:
		#var popup := visitor.embedded_small_popup.instantiate()
		#embedded_holder.add_child(popup)
#
		#if popup.has_method("setup_popup"):
			#popup.setup_popup(visitor)
#
	#refresh_popup()
#
#
#func refresh_popup() -> void:
	#await get_tree().process_frame
#
	## Let the VBox determine the required size
	#var new_size := vbox.get_combined_minimum_size() + CONTENT_PADDING
#
	## Preserve the bottom-right corner
	#var bottom_right := bubble.position + bubble.size
#
	#bubble.size = new_size
	#bubble.position = bottom_right - new_size
#
	## Resize the click area
	#var rect := collision_shape.shape as RectangleShape2D
	#rect.size = new_size
	#collision_shape.position = bubble.position + new_size * 0.5
#
#
#func _on_clickable_area_input_event(
	#_viewport: Node,
	#event: InputEvent,
	#_shape_idx: int
#) -> void:
	#if event.is_action_pressed("left_mouse"):
		#get_parent().switch_popup.emit()
#
#
#func format_timer(minutes: float) -> String:
	#var total_seconds := int(minutes * 60.0)
	#var mins := total_seconds / 60
	#var secs := total_seconds % 60
	#return "%d:%02d" % [mins, secs]
