class_name VisitorPopupLarge
extends Control

@onready var visitor_name_text: RichTextLabel = %VisitorNameText
@onready var header_art: TextureRect = %HeaderArt
@onready var popup_info_holder: Control = %PopupInfoHolder
@onready var sticking_around_text: RichTextLabel = %StickingAroundText
@onready var speech_bubble_entry: TextureRect = $NinePatchRect/SpeechBubbleEntry

var visitor_scene: VisitorScene
var visitor_resource: VisitorResource

func set_popup_info(visitor_scene: VisitorScene) -> void:
	visitor_resource = visitor_scene.visitor
	self.visitor_scene = visitor_scene
	visitor_name_text.text = visitor_resource.visitor_name
	if visitor_resource.large_popup_art != null:
		header_art.set_v_size_flags(Control.SIZE_EXPAND | Control.SIZE_FILL)
		header_art.texture = visitor_resource.large_popup_art
	else:
		header_art.texture = null
	for child in popup_info_holder.get_children():
		child.queue_free()
	if visitor_resource.embedded_large_popup != null:
		var dynamic_popup_portion := visitor_resource.embedded_large_popup.instantiate()
		popup_info_holder.add_child(dynamic_popup_portion)
		dynamic_popup_portion.setup_popup(visitor_resource)
	if visitor_resource.stick_around == false:
		sticking_around_text.text = "I'll be back eventually..."
	else:
		sticking_around_text.text = "I'll be around..."
	adjust_speech_bubble_entry(visitor_scene)

func _on_close_button_pressed() -> void:
	get_parent().start_timer_for_visitor.emit(visitor_scene)
	var blackout_curtain: Blackout = get_tree().get_nodes_in_group("Blackout")[0]
	blackout_curtain.hide_dark_overlay()
	for node in get_tree().get_nodes_in_group("FocusedVisitor"):
		node.remove_from_group("FocusedVisitor")
	if visitor_resource is TimedDifficulty: # might not be the most effective... update later possibly
		visitor_resource.apply_difficulty() 
	# self.visible = false
	get_parent().pause_visitors(false)

#########################################################
## Helpers ##############################################
#########################################################
func adjust_speech_bubble_entry(visitor_scene: Node2D) -> void:
	var mouth_position: Vector2 = visitor_scene.get_mouth_position()
	speech_bubble_entry.size.y = get_distance_from_edge_to_mouth(visitor_scene) - 10
	speech_bubble_entry.global_position.y = mouth_position.y + 20

func get_distance_from_edge_to_mouth(visitor_scene: Node2D) -> float:
	var mouth_global_position: Vector2 = visitor_scene.get_mouth_position()
	var nine_patch_right_edge: float = (
		$NinePatchRect.global_position.x
		+ $NinePatchRect.size.x
	)
	return mouth_global_position.x - nine_patch_right_edge
