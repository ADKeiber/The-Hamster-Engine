class_name TutorialStep
extends Resource

@export var text: String
#@export var target: Array[NodePath]
@export var step_number: int
@export var next_step: TutorialStep
@export var text_box_location: int # this is the location the textbox should show up in on the screen it is a 3x3 grid where 1 is top left and it reads like a book 
@export var steps_complete: bool = false
