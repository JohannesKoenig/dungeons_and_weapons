class_name QuickAccessResource
extends Resource

@export var inventory_resource: InventoryResource
@export var size: int
@export var selected_index: int:
	set(value):
		index_updated.emit(value)
signal index_updated(index: int)

func replace_item(target: Item, to_replace: Item) -> Item:
	for index in range(size):
		if inventory_resource.items[index] == target:
			return inventory_resource.add_at_position(to_replace, index)
	return null

func add_item_to_first_free_slot(item: Item) -> bool:
	var index = inventory_resource.add(item)
	return index != -1

func add_item(item: Item, index: int) -> Item:
	var replaced = inventory_resource.add_at_position(item, index)
	return replaced

func remove_item_at_index(index: int) -> Item:
	return inventory_resource.remove_at_index(index)

func remove_item(item: Item) -> bool:
	return inventory_resource.remove(item)

