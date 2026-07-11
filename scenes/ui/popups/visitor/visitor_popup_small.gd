class_name VisitorPopupSmall
extends Node2D

@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@onready var popup_contents: MarginContainer = %PopupContents

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#var old_height := nine_patch_rect.size.y
	#var new_size := popup_contents.size
	#nine_patch_rect.size = new_size
	#nine_patch_rect.position.y -= (new_size.y - old_height)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var old_height := nine_patch_rect.size.y
	var old_width  := nine_patch_rect.size.x
	var new_size := popup_contents.size
	nine_patch_rect.size = new_size
	nine_patch_rect.position.y -= (new_size.y - old_height)
	nine_patch_rect.position.x -= (new_size.x - old_width)
	pass
