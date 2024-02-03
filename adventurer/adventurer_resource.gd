extends Resource
class_name AdventurerResource

@export var coins: int
@export var inventory: InventoryResource
@export var quick_access: QuickAccessResource
@export var texture: Texture

func serialize() -> Dictionary:
	return {
		"coins": coins,
		"inventory": inventory.serialize(),
		"texture": texture.resource_path
	}

static func deserialize_from_dict(dict: Dictionary) -> AdventurerResource:
	var adventurer = AdventurerResource.new()
	adventurer.coins = dict["coins"]
	adventurer.quick_access = QuickAccessResource.new()
	adventurer.quick_access.selected_index = 0
	adventurer.inventory = InventoryResource.deserialize_from_dict(dict["inventory"])
	adventurer.texture = load(dict["texture"])
	return adventurer
