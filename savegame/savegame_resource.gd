class_name SaveGameResource
extends Resource

@export var name: String
@export var slot: int

@export var item_factory: ItemFactory = preload("res://items/item/item_factory.tres")
var SAVE_GAME_PATH = "user://save_%s.json"

var menu_save_resource = preload("res://savegame/menu_save_resource.tres")
var player_resource = preload("res://player/player_resource.tres")
var tavern_resource = preload("res://tavern/tavern_resource.tres")
var customers = preload("res://customers/customers_resource.tres")
var dungeon_inventory = preload("res://dungeon/dungeon_inventory.tres")
var dungeon_resource = preload("res://dungeon_spawner/dungeon_resource.tres")
var day_night_resoure: DayNightResource = preload("res://daynight/day_night_resource.tres")
var message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")

func _get_path(slot: int):
	return SAVE_GAME_PATH % str(slot)

func save_exists() -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH)

func write_savegame(slot: int = 1):
	var file := FileAccess.open(_get_path(slot), FileAccess.WRITE)
	var data := {
		"name": name,
		"slot": slot,
		"player_resource": player_resource.serialize(),
		"tavern_resource": {
			"inventory": tavern_resource.inventory.serialize()
		},
		"customers": {
			"available": customers.available.map(func(x): return x.serialize()),
			"today": customers.today.map(func(x): return x.serialize())
		},
		"dungeon_inventory": dungeon_inventory.serialize(),
		"dungeon_resource": dungeon_resource.serialize(),
		"day_night_resource": day_night_resoure.serialize(),
		"message_dispatcher": message_dispatcher.serialize()
	}
	
	var json_string := JSON.new().stringify(data)
	file.store_string(json_string)
	file.close()

func load_savegame(slot: int = 1):
	var file := FileAccess.open(_get_path(slot), FileAccess.READ)
	if !file:
		return
	var content = file.get_as_text()
	file.close()
	var data = JSON.parse_string(content)
	if data:
		name = data["name"]
		slot = data["slot"]
		player_resource.deserialize(data["player_resource"])
		tavern_resource.inventory.deserialize(data["tavern_resource"]["inventory"])
		customers.available = data["customers"]["available"].map(func(x): return AdventurerResource.deserialize_from_dict(x))
		customers.today = data["customers"]["today"].map(func(x): return AdventurerResource.deserialize_from_dict(x))
		dungeon_inventory.deserialize(data["dungeon_inventory"])
		dungeon_resource.deserialize(data["dungeon_resource"])
		day_night_resoure.deserialize(data["day_night_resource"])
