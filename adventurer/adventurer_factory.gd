class_name AdventurerFactory
extends Resource

@export var item_factory: ItemFactory = preload("res://items/item/item_factory.tres")
var _skin_builder: SkinBuilder = SkinBuilder.new()

func get_random() -> AdventurerResource:
	var adventurer_resource = AdventurerResource.new()
	adventurer_resource.coins = 5000
	adventurer_resource.inventory = InventoryResource.new()
	adventurer_resource.inventory.size = 1
	adventurer_resource.quick_access = QuickAccessResource.new()
	adventurer_resource.quick_access.size = 1
	adventurer_resource.quick_access.selected_index = 0
	adventurer_resource.quick_access.inventory_resource = adventurer_resource.inventory
	var skin_parts = _skin_builder.get_random()
	adventurer_resource.head = skin_parts["head"]
	adventurer_resource.body = skin_parts["body"]
	adventurer_resource.legs = skin_parts["legs"]
	
	for i in range(adventurer_resource.inventory.size):
		adventurer_resource.inventory.items.append(null)
	var indexes = range(0, adventurer_resource.inventory.size)
	indexes.shuffle()
	var amount_to_give = randi_range(0, len(indexes))
	var to_pick = indexes.slice(0, amount_to_give)
	for index in to_pick:
		adventurer_resource.inventory.add_at_position(item_factory.get_random(), index)
	return adventurer_resource
