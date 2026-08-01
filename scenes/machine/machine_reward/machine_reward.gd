class_name MachineReward
extends PanelContainer
@onready var reward_1_effect_1_label: Label = %Reward1Effect1Label
@onready var reward_1_effect_1_description: RichTextLabel = %Reward1Effect1Description
@onready var reward_1_effect_2_label: Label = %Reward1Effect2Label
@onready var reward_1_effect_2_description: RichTextLabel = %Reward1Effect2Description

@onready var reward_2_effect_1_label: Label = %Reward2Effect1Label
@onready var reward_2_effect_1_description: RichTextLabel = %Reward2Effect1Description
@onready var reward_2_effect_2_label: Label = %Reward2Effect2Label
@onready var reward_2_effect_2_description: RichTextLabel = %Reward2Effect2Description
@onready var panel_container_2: MarginContainer = $MarginContainer/VBoxContainer/Reward2
@onready var panel_container_1: MarginContainer = $MarginContainer/VBoxContainer/Reward1

const HOVER_REWARD_THEME = preload("uid://db6cutb2rghwx")

func set_reward_1(added_effect_1: GlobalEffect, added_effect_2: GlobalEffect) -> void:
	reward_1_effect_1_label.text = "+ %s"  % added_effect_1.effect_name
	reward_1_effect_1_description.text = added_effect_1.short_description
	
	reward_1_effect_2_label.text = "+ %s"  % added_effect_2.effect_name
	reward_1_effect_2_description.text = added_effect_2.short_description

func set_reward_2(added_effect: GlobalEffect, removed_effect: GlobalEffect) -> void:
	reward_2_effect_1_label.text = "+ %s"  % added_effect.effect_name
	reward_2_effect_1_description.text = added_effect.short_description
	
	reward_2_effect_2_label.text = "- %s"  % removed_effect.effect_name
	reward_2_effect_2_description.text = removed_effect.short_description


func _on_reward_2_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		get_parent().reward_2_pressed()

func _on_reward_2_mouse_entered() -> void:
	panel_container_2.theme = HOVER_REWARD_THEME

func _on_reward_2_mouse_exited() -> void:
	panel_container_2.theme = null

func _on_reward_1_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		get_parent().reward_1_pressed()

func _on_reward_1_mouse_entered() -> void:
	panel_container_1.theme = HOVER_REWARD_THEME


func _on_reward_1_mouse_exited() -> void:
	panel_container_1.theme = null
