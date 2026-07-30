class_name GlobalEffectsDisplay
extends PanelContainer

@onready var foldable_v_box: VBoxContainer = %FoldableVBox
@onready var current_effect_name: Label = %CurrentEffectName
@onready var current_effect_description: Label = %CurrentEffectDescription

var current_effect: GlobalEffect
var other_effects: Array[GlobalEffect]

func set_current_effect(new_current: GlobalEffect) -> void:
	current_effect = new_current
	current_effect_name.text = current_effect.effect_name
	current_effect_description.text = current_effect.short_description

func add_effect_to_other(new_other: GlobalEffect) -> void:
	other_effects.append(new_other)
	var effect_name: Label = Label.new()
	foldable_v_box.add_child(effect_name)
	effect_name.text = "%s:" % new_other.effect_name
	effect_name.add_theme_font_size_override("font_size", 8)
	
	var description := Label.new()
	foldable_v_box.add_child(description)
	description.text = new_other.short_description
	description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	description.add_theme_font_size_override("font_size", 6)
	description.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
