class_name GlobalEffectsDisplay
extends PanelContainer
const GLOBAL_EFFECT_CARD = preload("uid://bkxfoimcq6gof")



@onready var foldable_v_box: VBoxContainer = %FoldableVBox
@onready var current_effect_name: Label = %CurrentEffectName
@onready var current_effect_description: Label = %CurrentEffectDescription
@onready var scroll_container: ScrollContainer = %ScrollContainer
@onready var more_information_popup: Node2D = %MoreInformationPopup
@onready var more_info_name: Label = %MoreInfoName
@onready var moreinfo_description: RichTextLabel = %MoreinfoDescription

var current_effect: GlobalEffect
var other_effects: Array[GlobalEffect]

func _ready() -> void:
	Effects.effects_updated.connect(update_effect_display)
	var scrollbar := scroll_container.get_v_scroll_bar()
	Effects.show_more_effect_details.connect(display_additional_info)
	
	var stylebox := scrollbar.get_theme_stylebox("scroll").duplicate()
	stylebox.content_margin_left = 1
	stylebox.content_margin_right = 1

	scrollbar.add_theme_stylebox_override("scroll", stylebox)

func update_effect_display() -> void:
	## updates "current effect"
	current_effect_name.text = current_effect.effect_name
	current_effect_description.text = current_effect.short_description
	## All effects section
	for child in foldable_v_box.get_children():
		child.queue_free()
	
	for effect in Effects.all_effects:
		var effect_card: GlobalEffectCard = GLOBAL_EFFECT_CARD.instantiate()
		foldable_v_box.add_child(effect_card)
		effect_card.set_effect(effect)

func display_additional_info(show:bool, effect: GlobalEffect) -> void:
	more_information_popup.visible = show
	more_info_name.text = effect.effect_name
	moreinfo_description.text = effect.short_description
