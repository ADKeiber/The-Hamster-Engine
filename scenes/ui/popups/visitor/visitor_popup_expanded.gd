class_name VisitorPopupExpanded
extends Control
@onready var visitor_name_text: RichTextLabel = %VisitorNameText
@onready var header_art: TextureRect = %HeaderArt
@onready var popup_info_holder: Control = %PopupInfoHolder
@onready var sticking_around_text: RichTextLabel = %StickingAroundText

func set_popup_info(visitor: VisitorResource) -> void:
	visitor_name_text.text = visitor.visitor_name
	header_art.texture = visitor.large_popup_art
	var dynamic_popup_portion := visitor.embedded_large_popup.instantiate()
	dynamic_popup_portion.setup_popup(visitor)
	popup_info_holder.add_child(dynamic_popup_portion)
	if visitor.stick_around == false:
		sticking_around_text.text = "Alright I'll be back eventually..."
	else:
		sticking_around_text.text = "I'll be around if you need me!"

func _on_close_button_pressed() -> void:
	get_parent().switch_popup.emit()
