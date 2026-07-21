class_name EmbeddedTimedDifficultyLarge
extends VBoxContainer

@onready var flavor_text_field: RichTextLabel = %FlavorTextField
@onready var effect_information: EffectInformationPanel = $EffectInformation

func setup_popup(visitor_resource:VisitorResource) -> void:
	if visitor_resource is TimedDifficulty:
		flavor_text_field.text = flavor_text_field.text % [visitor_resource.visitor_name]
		effect_information.set_information( visitor_resource.effect.effect_name, visitor_resource.effect.description % [visitor_resource.effect.amount, visitor_resource.time_to_complete])
