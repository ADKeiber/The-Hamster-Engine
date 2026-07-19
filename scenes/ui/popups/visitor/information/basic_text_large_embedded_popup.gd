class_name BasicTextLargeEmbeddedPopup
extends VBoxContainer
@onready var flavor_text_field: RichTextLabel = %FlavorTextField
@onready var effect_information: RichTextLabel = %EffectInformation
@onready var effect_name: Label = %EffectName

func setup_popup(visitor_resource:VisitorResource) -> void:
	if visitor_resource is TimedDifficulty:
		flavor_text_field.text = flavor_text_field.text % [visitor_resource.visitor_name]
		effect_name.text = visitor_resource.effect.effect_name
		effect_information.text = visitor_resource.effect.description % [visitor_resource.effect.amount, visitor_resource.time_to_complete]
