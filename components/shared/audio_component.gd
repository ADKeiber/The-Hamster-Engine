class_name AudioComponent
extends Node2D

var audio_library: AudioLibraryResource
@onready var player: AudioStreamPlayer2D = $AudioStreamPlayer2D


func play(id: StringName) -> void:
	if audio_library == null:
		push_error("AudioComponent has no AudioLibraryResource assigned.")
		return

	var clip := audio_library.get_sound(id)
	if clip == null:
		return

	_apply_clip(clip)

	if clip.randomize_pitch:
		player.pitch_scale += randf_range(-clip.pitch_variance, clip.pitch_variance)

	if clip.randomize_volume:
		player.volume_db += randf_range(-clip.volume_variance_db, clip.volume_variance_db)

	if clip.interrupt_current_sound or !player.playing:
		player.play()

func stop() -> void:
	player.stop()

func is_playing() -> bool:
	return player.playing

func _apply_clip(clip: AudioClipResource) -> void:
	player.stream = clip.stream
	player.bus = clip.bus
	player.volume_db = clip.volume_db
	player.pitch_scale = clip.pitch_scale
	player.max_polyphony = clip.max_polyphony

	player.attenuation = clip.attenuation
	player.max_distance = clip.max_distance
	player.panning_strength = clip.panning_strength
	player.area_mask = clip.area_mask

func set_library(library: AudioLibraryResource) -> void:
	audio_library = library
