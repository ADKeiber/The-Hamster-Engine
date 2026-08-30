class_name GlobalEffectCard
extends PanelContainer
@onready var effect_name: Label = %EffectName
@onready var effect_short_description: RichTextLabel = %EffectShortDescription
@onready var entire_information: Node2D = %EntireInformation
var effect: GlobalEffect
func set_effect(effect:GlobalEffect) -> void:
	self.effect = effect
	effect_name.text = effect.effect_name
	#IDK if this should be visible or not
	#effect_short_description.text = effect.short_description 

func _on_mouse_entered() -> void:
	Effects.show_more_effect_details.emit(true,effect)

func _on_mouse_exited() -> void:
	Effects.show_more_effect_details.emit(false,effect)
