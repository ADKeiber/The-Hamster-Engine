class_name EmbeddedTimedDifficultySmall
extends VBoxContainer
@onready var difficulty_description: RichTextLabel = %DifficultyDescription
@onready var difficulty_name: Label = %DifficultyName

var vis: TimedDifficulty
func setup_popup(visitor: VisitorResource) -> void:
	if not visitor is TimedDifficulty:
		return
	vis = visitor
	difficulty_description.text = vis.effect.description % [vis.effect.amount, vis.time_to_complete]
	difficulty_name.text = vis.effect.effect_name
