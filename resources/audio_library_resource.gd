class_name AudioLibraryResource extends Resource

@export var sounds: Dictionary[StringName, AudioClipResource] = {}

func has_sound(id: StringName) -> bool:
	return sounds.has(id)

func get_sound(id: StringName) -> AudioClipResource:
	if sounds.has(id):
		return sounds[id]
	push_warning("AudioLibraryResource: Sound '%s' not found." % id)
	return null

func _to_string() -> String:
	var output := "Audio Library:\n"
	for id in sounds.keys():
		output += "  %s\n" % id
	return output
