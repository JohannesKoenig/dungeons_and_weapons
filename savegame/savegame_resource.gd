class_name SaveGameResource
extends Resource

@export var item_factory: ItemFactory = preload("res://items/item/item_factory.tres")
var SAVE_GAME_PATH = "user://save.json"

var player_resource = preload("res://player/player_resource.tres")
var tavern_resource = preload("res://tavern/tavern_resource.tres")
var customers = preload("res://customers/customers_resource.tres")
var dungeon_inventory = preload("res://dungeon/dungeon_inventory.tres")

func save_exists() -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH)

func write_savegame():
	var file := FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	var data := {
		"player_resource": player_resource.serialize(),
		"tavern_resource": {
			"inventory": tavern_resource.inventory.serialize()
		},
		"customers": {
			"available": customers.available.map(func(x): return x.serialize()),
			"today": customers.today.map(func(x): return x.serialize())
		},
		"dungeon_inventory": dungeon_inventory.serialize()
	}
	
	var json_string := JSON.new().stringify(data)
	file.store_string(json_string)
	file.close()

func load_savegame():
	var file := FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	if !file:
		return
	var content = file.get_as_text()
	file.close()
	var data = JSON.parse_string(content)
	if data:
		player_resource.deserialize(data["player_resource"])
		tavern_resource.inventory.deserialize(data["tavern_resource"]["inventory"])
		customers.available = data["customers"]["available"].map(func(x): return AdventurerResource.deserialize_from_dict(x))
		customers.today = data["customers"]["today"].map(func(x): return AdventurerResource.deserialize_from_dict(x))
		dungeon_inventory.deserialize(data["dungeon_inventory"])
