class_name VisitorResource extends Resource

signal leave 
## Most visitors leave after a certain amount of time BUT if there is one that leaves if a condition is met
## Then they will emit the leave signal.. This should happen in the implemented version of handle_tick

@export_group("General")
@export var sprite_frames: SpriteFrames
@export var visitor_name: String
@export var stick_around: bool
@export var time_to_complete: float = 0.0 ## this is in seconds
@export var type: VisitorType
@export var failed: bool = false

## NOTE: These messages are designed to be 3 rows of text in the UI... seperate by [br]
@export var goodbye_messages_pass: String

@export_group("Small Popup")
@export var small_popup: PackedScene
@export var small_information_text: String

@export_group("Large Popup")
@export var embedded_large_popup: PackedScene
@export var large_popup_art: CompressedTexture2D

enum VisitorType {STORE, TIMED_DIFFICULTY, OBJECTIVE} # Add to these as needed

var time_remaining: int = 0

func setup() -> void:
	pass

func handle_tick() -> void:
	pass

func complete() -> void:
	pass

func fail() -> void:
	pass
