extends Node



var all_traits : Array[TraitResource]
var all_hamster_types : Array[HamsterTypeResource]
var all_buildings : Array[BuildingResource]

func _ready() -> void:
	load_resources("res://resources/hamster/traits", all_traits)
	load_resources("res://resources/hamster/types", all_hamster_types)
	load_resources("res://resources/building/buidling", all_buildings)


func load_resources(path : String, array : Array) -> void:
	var dir := DirAccess.open(path)
	if dir == null:
		push_error("Couldn't open directory: " + path)
		return
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			if file_name != "." and file_name != "..":
				load_resources(path.path_join(file_name), array)
		else:
			if file_name.ends_with(".tres"):
				var resource = load(path.path_join(file_name))
				if resource is Resource:
					array.append(resource)
		file_name = dir.get_next()
	dir.list_dir_end()
