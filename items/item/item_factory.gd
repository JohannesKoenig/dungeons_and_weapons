class_name ItemFactory
extends Resource

@export var items = {}

func get_random() -> Item:
	var item = items.values().pick_random()
	return item.duplicate()

func load_weapons():
	var base_path = "res://Resources/weapons"
	var dir = DirAccess.open(base_path)
	dir.list_dir_begin()
	while true:
		var sub_dir = dir.get_next()
		if sub_dir == "":
			#break the while loop when get_next() returns ""
			break
		var sub_path = base_path + "/" + sub_dir
		if DirAccess.dir_exists_absolute(sub_path):
			var resource_path = sub_path + "/weapon.tres"
			items[sub_dir] = ResourceLoader.load(resource_path)
	dir.list_dir_end()

func load_items():
	var base_path = "res://Resources/items"
	var dir = DirAccess.open(base_path)
	dir.list_dir_begin()
	while true:
		var sub_dir = dir.get_next()
		if sub_dir == "":
			#break the while loop when get_next() returns ""
			break
		var sub_path = base_path + "/" + sub_dir
		if DirAccess.dir_exists_absolute(sub_path):
			var resource_path = sub_path + "/item.tres"
			items[sub_dir] = ResourceLoader.load(resource_path)
	dir.list_dir_end()
