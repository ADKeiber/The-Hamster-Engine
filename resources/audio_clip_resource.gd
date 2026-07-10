class_name AudioClipResource extends Resource

@export_group("Audio")
@export var stream: AudioStream

@export_group("Volume")
@export_range(-80.0, 24.0, 0.1)
var volume_db: float = 0.0

@export_range(0.0, 1.0, 0.01)
var volume_linear: float = 1.0

@export_group("Pitch")
@export_range(0.01, 4.0, 0.01)
var pitch_scale: float = 1.0

@export_group("Bus")
@export var bus: StringName = &"Master"

@export_group("Playback")
@export var autoplay: bool = false

@export var max_polyphony: int = 1

@export_group("2D")
@export var max_distance: float = 2000.0
@export var attenuation: float = 1.0
@export var panning_strength: float = 1.0

@export_group("Randomization")
@export var randomize_pitch: bool = false

@export_range(0.0, 1.0, 0.01)
var pitch_variance: float = 0.0

@export var randomize_volume: bool = false

@export_range(0.0, 24.0, 0.1)
var volume_variance_db: float = 0.0

@export_group("Behavior")
@export var interrupt_current_sound: bool = true
@export var loop_if_supported: bool = false

@export var area_mask: int

func _to_string() -> String:
	return """
AudioClipResource:
  Stream: %s
  Bus: %s
  Volume (dB): %.2f
  Volume (Linear): %.2f
  Pitch Scale: %.2f
  Autoplay: %s
  Max Polyphony: %d
  Max Distance: %.2f
  Attenuation: %.2f
  Panning Strength: %.2f
""" % [
		stream,
		bus,
		volume_db,
		volume_linear,
		pitch_scale,
		autoplay,
		max_polyphony,
		max_distance,
		attenuation,
		panning_strength
	]
