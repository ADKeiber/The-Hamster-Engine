extends Area2D

@onready var shape : CollisionShape2D = $CollisionShape2D
@export var foorprint : FootprintComponent
@export var placeable : PlaceableComponent


func _ready() -> void:
	placeable.sig_placed.connect(set_area, CONNECT_ONE_SHOT)



func set_area() -> void:
	shape.shape.set_size(Vector2(foorprint.footprint.x, foorprint.footprint.y))
