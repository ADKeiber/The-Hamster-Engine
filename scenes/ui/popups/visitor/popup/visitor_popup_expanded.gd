class_name VisitorPopupExpanded
extends Control

@onready var visitor_name_text: RichTextLabel = %VisitorNameText
@onready var header_art: TextureRect = %HeaderArt
@onready var popup_info_holder: Control = %PopupInfoHolder
@onready var sticking_around_text: RichTextLabel = %StickingAroundText
@onready var speech_bubble_entry: TextureRect = $NinePatchRect/SpeechBubbleEntry

var vis: VisitorResource

func set_popup_info(visitor_scene: VisitorScene) -> void:
	vis = visitor_scene.visitor
	visitor_name_text.text = vis.visitor_name
	header_art.texture = vis.large_popup_art
	if vis.embedded_large_popup != null:
		var dynamic_popup_portion := vis.embedded_large_popup.instantiate()
		dynamic_popup_portion.setup_popup(vis)
		popup_info_holder.add_child(dynamic_popup_portion)
	if vis.stick_around == false:
		sticking_around_text.text = "Alright I'll be back eventually..."
	else:
		sticking_around_text.text = "I'll be around if you need me!"
	adjust_speech_bubble_entry(visitor_scene)

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

func _on_close_button_pressed() -> void:
	get_parent().start_timer_for_visitor.emit(vis)
	var blackout_curtain:Blackout = get_tree().get_nodes_in_group("Blackout")[0]
	blackout_curtain.hide_dark_overlay()
	for node in get_tree().get_nodes_in_group("FocusedVisitor"):
		node.remove_from_group("FocusedVisitor")
	get_parent().pause_visitors(false)
