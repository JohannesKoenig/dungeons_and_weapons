class_name PlayerResource
extends Resource

@export var inventory: InventoryResource
@export var quick_access: QuickAccessResource
@export var health_resource: HealthResource = preload("res://player/player_health_resource.tres")
@export var coins: int:
	set(value):
		coins_changed.emit(value)
		coins_changed_delta.emit(value, value - coins)
		coins = value
@export var head: Texture
@export var body: Texture
@export var legs: Texture
var tavern_global_position: Vector2 = Vector2(128, 128)
var dungeon_global_position: Vector2 = Vector2(0, 4)

signal coins_changed(coins: int)
signal coins_changed_delta(coins: int, delta: int)


func set_coins(value: int):
	coins = value
	coins_changed.emit(coins)

func serialize() -> Dictionary:
	return {
		"coins": coins,
		"inventory": inventory.serialize(),
		"quick_access": {
			"size": quick_access.size,
			"selected_index": quick_access.selected_index,
		},
		"head": head.resource_path,
		"body": body.resource_path,
		"legs": legs.resource_path,
		"health": health_resource.serialize(),
		"tavern_global_position": {
			"x": tavern_global_position.x,
			"y": tavern_global_position.y
		},
		"dungeon_global_position": {
			"x": dungeon_global_position.x,
			"y": dungeon_global_position.y
		}
	}

func deserialize(data: Dictionary):
	set_coins(data["coins"])
	inventory.deserialize(data["inventory"])
	quick_access.size = data["quick_access"]["size"]
	quick_access.selected_index = data["quick_access"]["selected_index"]
	head = load(data["head"])
	body = load(data["body"])
	legs = load(data["legs"])
	health_resource.deserialize(data["health"])
	tavern_global_position = Vector2(data["tavern_global_position"]["x"], data["tavern_global_position"]["y"])
	dungeon_global_position = Vector2(data["dungeon_global_position"]["x"], data["dungeon_global_position"]["y"])
