class_name MenuSaveResource extends Resource
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var saveslot_resources: Dictionary = {}
var ambient_sound_level: int = 0:
	set(value):
		ambient_sound_level = value
		ambiant_sound_level_changed.emit(value)
signal ambiant_sound_level_changed(value:int)
var music_sound_level: int = 0:
	set(value):
		music_sound_level = value
		music_sound_level_changed.emit(value)
signal music_sound_level_changed(value:int)
var combat_sound_level: int = 0:
	set(value):
		combat_sound_level = value
		combat_sound_level_changed.emit(value)
signal combat_sound_level_changed(value:int)
var selected_saveslot: int = 1
var MENU_SAVE_PATH = "user://menu_save.json"
signal saveslot_resource_changed(slots: Array)
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func save_exists() -> bool:
	return FileAccess.file_exists(MENU_SAVE_PATH)

func write_savegame():
	var file := FileAccess.open(MENU_SAVE_PATH, FileAccess.WRITE)
	var data := serialize()
	var json_string := JSON.new().stringify(data)
	file.store_string(json_string)
	file.close()

func load_savegame():
	var file := FileAccess.open(MENU_SAVE_PATH, FileAccess.READ)
	if !file:
		return
	var content = file.get_as_text()
	file.close()
	var data = JSON.parse_string(content)
	if data:
		deserialize(data)

func serialize() -> Dictionary:
	return {
		
		"save_slots": saveslot_resources.values().map(func(x): return x.serialize()),
		"ambient": ambient_sound_level,
		"music": music_sound_level,
		"combat": combat_sound_level
	}

func deserialize(data: Dictionary):
	saveslot_resources = {}
	for slot in data["save_slots"]:
		var res = SaveslotResource.new()
		res.deserialize(slot)
		saveslot_resources[res.slot] = res
	ambient_sound_level = data["ambient"]
	music_sound_level = data["music"]
	combat_sound_level = data["combat"]
	saveslot_resource_changed.emit(saveslot_resources.values())
	

func remove_slot(slot: int):
	saveslot_resources.erase(slot)
	saveslot_resource_changed.emit(saveslot_resources.values())
	
func delete(slot: int):
	saveslot_resources.erase(slot)
	return DirAccess.remove_absolute("user://save_%s.json" % slot)
