class_name SaveGameResource
extends Resource

var SAVE_GAME_PATH = "user://save.json"

var player_resource = preload("res://player/player_resource.tres")
var tavern_resource = preload("res://tavern/tavern_resource.tres")


func save_exists() -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH)

func write_savegame():
	var file := FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	
	var data := {
		"player_resource": {
			"coins": player_resource.coins,
			"inventory": inventory_to_data(player_resource.inventory),
			"quick_access": {
				"size": player_resource.quick_access.size,
				"selected_index": player_resource.quick_access.selected_index,
			},
			"texture": player_resource.texture
		},
		"tavern_resource": {
			"inventory": inventory_to_data(tavern_resource.inventory)
		}
	}
	
	var json_string := JSON.new().stringify(data)
	file.store_string(json_string)
	file.close()

func load_savegame():
	var file := FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	var data: Dictionary = JSON.parse_string(content)
	player_resource.coins = data["player_resource"]["coins"]
	player_resource.inventory.size = data["player_resource"]["inventory"]["size"]
	player_resource.inventory.items = data["player_resource"]["inventory"]["items"]

func inventory_to_data(inventory: InventoryResource) -> Dictionary:
	return {
		"size": inventory.size,
		"items": inventory.items
	}
