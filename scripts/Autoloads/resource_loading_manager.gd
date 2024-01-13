extends Node

var path_to_texture: Dictionary = {}

func load_resource(path: String) -> Resource:
	return load(path)

func get_texture(path: String) -> Texture:
	if path not in path_to_texture:
		path_to_texture[path] = load_resource(path)
	return path_to_texture[path]
