extends Resource
class_name AdventurerResource

@export var coins: int
@export var inventory: InventoryResource
@export var quick_access: QuickAccessResource
@export var head: Texture
@export var body: Texture
@export var legs: Texture
var is_returning = false

func serialize() -> Dictionary:
	return {
		"coins": coins,
		"inventory": inventory.serialize(),
		"head": head.resource_path,
		"body": body.resource_path,
		"legs": legs.resource_path,
	}

static func deserialize_from_dict(dict: Dictionary) -> AdventurerResource:
	var adventurer = AdventurerResource.new()
	adventurer.coins = dict["coins"]
	adventurer.quick_access = QuickAccessResource.new()
	adventurer.quick_access.selected_index = 0
	adventurer.inventory = InventoryResource.deserialize_from_dict(dict["inventory"])
	adventurer.head = ResourceLoader.load(dict["head"])
	adventurer.body = ResourceLoader.load(dict["body"])
	adventurer.legs = ResourceLoader.load(dict["legs"])
	return adventurer
