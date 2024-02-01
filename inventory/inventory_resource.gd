class_name InventoryResource
extends Resource

@export var size: int
@export var items: Array

signal items_changed(items: Array)

func add(item: Item) -> int:
	for i in range(len(items)):
		if items[i] == null:
			items[i] = item
			items_changed.emit(items)
			return i
	return -1

func add_at_position(item: Item, index: int) -> Item:
	var old_item = items[index]
	items[index] = item
	items_changed.emit(items)
	return old_item

func remove(item: Item) -> bool:
	for i in range(len(items)):
		if items[i] == item:
			items[i] = null
			items_changed.emit(items)
			return true
	return false

func remove_at_index(index: int) -> Item:
	var to_remove = items[index]
	items[index] = null
	return to_remove
