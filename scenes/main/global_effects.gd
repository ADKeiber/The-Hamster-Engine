class_name GlobalEffectsDisplay
extends PanelContainer
const GLOBAL_EFFECT_CARD = preload("uid://bkxfoimcq6gof")

@onready var current_effect_name: Label = %CurrentEffectName
@onready var current_effect_description: Label = %CurrentEffectDescription
@onready var more_information_popup: Node2D = %MoreInformationPopup
@onready var more_info_name: Label = %MoreInfoName
@onready var moreinfo_description: RichTextLabel = %MoreinfoDescription


@onready var all_effects_area: VBoxContainer = %AllEffectsArea
@onready var show_effects_button: Button = %ShowEffectsButton
@onready var scroll_container: ScrollContainer = %ScrollContainer


var current_effect: GlobalEffect
var other_effects: Array[GlobalEffect]
var total_height: int = 0

func _ready() -> void:
	Effects.effects_updated.connect(update_effect_display)
	Effects.show_more_effect_details.connect(display_additional_info)
	
	var scrollbar := scroll_container.get_v_scroll_bar()
	var stylebox := scrollbar.get_theme_stylebox("scroll").duplicate()
	stylebox.content_margin_left = 1
	stylebox.content_margin_right = 1
	scrollbar.add_theme_stylebox_override("scroll", stylebox)

func update_effect_display() -> void:
	current_effect_name.text = current_effect.effect_name
	current_effect_description.text = current_effect.short_description
	##Loops through and deletes any non active effects
	for child in all_effects_area.get_children():
		var still_active: bool = false
		for id in Effects.get_ids():
			if id == child.effect.instance_id:
				still_active = true
		if not still_active:
			child.queue_free()
	##Loops through and adds any effects that are missing
	for id in Effects.get_ids():
		var displayed: bool = false
		for child in all_effects_area.get_children():
			if id == child.effect.instance_id:
				displayed = true
		if not displayed:
			var ge: GlobalEffect = Effects.get_by_id(id)
			if ge != null:
				var effect_card: GlobalEffectCard = GLOBAL_EFFECT_CARD.instantiate()
				all_effects_area.add_child(effect_card)
				effect_card.set_effect(ge)
	close_effects_area() # should probably just resize some things.. but this works for now


func display_additional_info(show:bool, effect: GlobalEffect) -> void:
	more_information_popup.visible = show
	more_info_name.text = effect.effect_name
	moreinfo_description.text = effect.short_description


var showing: bool = false

func _on_show_effects_button_pressed() -> void:
	showing = not showing
	if showing:
		open_effects_area()
	else: 
		close_effects_area()

func close_effects_area() -> void:
	showing = false
	show_effects_button.text = "Show All Effects"
	
	scroll_container.custom_minimum_size = Vector2.ZERO
	all_effects_area.visible = false
	scroll_container.scroll_vertical = 0

func open_effects_area() -> void:
	showing = true
	all_effects_area.visible = true
	show_effects_button.text = "Close All Effects"
	await get_tree().process_frame
	
	var content_height := all_effects_area.get_combined_minimum_size().y
	scroll_container.custom_minimum_size = Vector2(
		95,
		mini(content_height, 100)
	)

	scroll_container.scroll_vertical = 0
