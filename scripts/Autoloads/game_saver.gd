extends Node

var save_slot: int = 1
var SAFE_FILE_PREFIX = "save_file"
var save_game_resource = SaveGameResource.new()

func save_game_from_resources():
	save_game_resource.write_savegame(save_slot)

func load_game_from_resources():
	save_game_resource.load_savegame(save_slot)

func save_game(save_slot: int, save_name: String):
	var save_game = FileAccess.open(_get_file_name(save_slot), FileAccess.WRITE)
	var json_string = JSON.stringify({
		"name": save_name
	})
	save_game.store_line(json_string)


# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_game(save_slot: int) -> SaveFile:
	if not FileAccess.file_exists(_get_file_name(save_slot)):
		return null
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_game = FileAccess.open(_get_file_name(save_slot), FileAccess.READ)
	var json_string = save_game.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return null

	# Get the data from the JSON object
	var save_data = json.get_data()
	return SaveFile.from_values(save_data["name"], save_slot)


func delete_game(save_file: SaveFile):
	DirAccess.remove_absolute(_get_file_name(save_file.slot))


func _get_file_name(save_slot: int) -> String:
	return "user://%s_%s.save" % [SAFE_FILE_PREFIX, save_slot]
