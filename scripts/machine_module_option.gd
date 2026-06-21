class_name MachineModuleOption
extends HBoxContainer
@onready var option_texture_rect: TextureRect = $Texture
@onready var option_name: Label = $VBoxContainer/Name
@onready var option_description: RichTextLabel = $VBoxContainer/Description

func set_option(name: String, description: String, texture: Texture2D) -> void:
	option_texture_rect.texture = texture
	option_name.text = name
	option_description.text = description
