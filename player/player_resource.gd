class_name PlayerResource
extends Resource

@export var inventory: InventoryResource
@export var quick_access: QuickAccessResource
@export var coins: int
@export var texture: Texture

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
	coins = data["coins"]
	inventory.deserialize(data["inventory"])
	quick_access.size = data["quick_access"]["size"]
	quick_access.selected_index = data["quick_access"]["selected_index"]
	texture = load(data["texture"])
