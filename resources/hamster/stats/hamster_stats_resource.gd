class_name HamsterStatsResource
extends Resource

#NOTE STATS Contain "live in Stats" these decide how hamster behaves

@export_group("Health")
@export var max_health: int
@export var health_drain: int
@export var healing_rate: int

@export_group("Stamina")
@export var max_stamina: int
@export var stamina_drain: int
@export var stamina_regen_rate: int

@export_group("Misc")
@export var speed: int
@export var max_traits: int
@export var traits: Array[TraitResource]
@export var hamster_type: HamsterTypeResource
@export var audio_library: AudioLibraryResource
@export var condition: Condition

@export_group("Assets")
@export var sprite_frames: SpriteFrames
@export var basic_sprite: CompressedTexture2D



func _to_string() -> String:
	return """
HamsterStatsResource:
  Health:
    Max Health: %d
    Health Drain: %d
    Healing Rate: %d
  Stamina:
    Max Stamina: %d
    Stamina Drain: %d
    Stamina Regen Rate: %d
  Misc:
    Speed: %d
    Max Traits: %d
    Traits: %d
    Hamster Type: %s
  Assets:
    Sprite Frames: %s
    Basic Sprite: %s
""" % [
		max_health,
		health_drain,
		healing_rate,
		max_stamina,
		stamina_drain,
		stamina_regen_rate,
		speed,
		max_traits,
		traits.size(),
		hamster_type,
		sprite_frames,
		basic_sprite
	]
