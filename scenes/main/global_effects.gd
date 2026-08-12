class_name GlobalEffectsDisplay
extends PanelContainer

@onready var foldable_v_box: VBoxContainer = %FoldableVBox
@onready var current_effect_name: Label = %CurrentEffectName
@onready var current_effect_description: Label = %CurrentEffectDescription

var current_effect: GlobalEffect
var other_effects: Array[GlobalEffect]

func _ready() -> void:
	Effects.effects_updated.connect(update_effect_display)

func update_effect_display() -> void:
	## updates "current effect"
	current_effect_name.text = current_effect.effect_name
	current_effect_description.text = current_effect.short_description
	## All effects section
	for child in foldable_v_box.get_children():
		child.queue_free()
	
	for effect in Effects.all_effects:
		var effect_name: Label = Label.new()
		foldable_v_box.add_child(effect_name)
		effect_name.text = "%s:" % effect.effect_name
		effect_name.add_theme_font_size_override("font_size", 8)
		
		var description := Label.new()
		foldable_v_box.add_child(description)
		description.text = effect.short_description
		description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		description.add_theme_font_size_override("font_size", 6)
		description.size_flags_horizontal = Control.SIZE_EXPAND_FILL
