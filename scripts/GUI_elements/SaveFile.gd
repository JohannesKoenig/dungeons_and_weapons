class_name SaveFile

var name: String
var slot: int

static func from_values(name: String, slot: int) -> SaveFile:
	var save_file = SaveFile.new()
	save_file.name = name
	save_file.slot = slot
	return save_file
