class_name EffectInformationPanel
extends PanelContainer
@onready var effect_information: RichTextLabel = $Row/EffectInformation
@onready var effect_name_label: Label = $Row/EffectName

func set_information(effect_name: String, effect_description: String) -> void:
	effect_name_label.text = effect_name
	effect_information.text = effect_description
