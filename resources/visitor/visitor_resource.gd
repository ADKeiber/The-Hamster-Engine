class_name VisitorResource extends Resource

@export_group("General")
@export var sprite_frames: SpriteFrames
@export var visitor_name: String
@export var stick_around: bool
@export var time_to_complete: float = 0.0 ## this is in seconds
@export var type: VisitorType
@export var waiting_position: Vector2

@export_group("Small Popup")
@export var small_popup: PackedScene
@export var small_information_text: String

@export_group("Large Popup")
@export var embedded_large_popup: PackedScene
@export var large_information_text: String
@export var large_popup_art: CompressedTexture2D

enum VisitorType {STORE, TIMED_DIFFICULTY} # Add to these as needed
