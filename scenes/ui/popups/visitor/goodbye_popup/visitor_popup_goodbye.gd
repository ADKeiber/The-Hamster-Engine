class_name VisitorPopupGoodbye
extends Control

@onready var goodbye_message: RichTextLabel = %GoodbyeMessage

func set_message(visitor: VisitorResource) -> void:
	if visitor.failed:
		goodbye_message.text = visitor.goodbye_message_fail
	else:
		goodbye_message.text = visitor.goodbye_messages_pass
