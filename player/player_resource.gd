class_name PlayerResource
extends Resource

@export var inventory: InventoryResource
@export var quick_access: QuickAccessResource
@export var coins: int:
	set(value):
		coins_changed.emit(value)
		coins_changed_delta.emit(value, value - coins)
		coins = value
@export var texture: Texture

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
		"texture": texture.resource_path
	}

func deserialize(data: Dictionary):
	set_coins(data["coins"])
	inventory.deserialize(data["inventory"])
	quick_access.size = data["quick_access"]["size"]
	quick_access.selected_index = data["quick_access"]["selected_index"]
	texture = load(data["texture"])
