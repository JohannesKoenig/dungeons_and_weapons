class_name SkinBuilder extends Resource
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var heads = import_from_folder("res://skin_builder/head")
var legs = import_from_folder("res://skin_builder/legs")
var bodies = import_from_folder("res://skin_builder/body")
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func get_random() -> Dictionary:
	return {
		"head" = heads.pick_random(),
		"legs" = legs.pick_random(),
		"body" = bodies.pick_random()
	}

static func import_from_folder(path: String) -> Array:
	var pics = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with(".") and file_name.ends_with(".import"):
			#if !file_name.ends_with(".import"):
			var no_import = file_name.trim_suffix(".import")
			pics.append(ResourceLoader.load(path + "/" + no_import))
	dir.list_dir_end()
	return pics
