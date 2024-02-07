class_name InventoryResource
extends Resource

@export var size: int
@export var items: Array

signal items_changed(items: Array)
var _item_factory = preload("res://items/item/item_factory.tres")

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
	items_changed.emit(items)
	return to_remove

func get_index(item: Item) -> int:
	for i in range(len(items)):
		if item == items[i]:
			return i
	return -1

func clear():
	for i in range(len(items)):
		items[i] = null
	items_changed.emit(items)


func serialize() -> Dictionary:
	return {
		"size": size,
		"items": items.map(func(x): return _serialize_item(x))
	}

func deserialize(dict: Dictionary):
	size = dict["size"]
	items = dict["items"].map(func(x): return _deserialize_item(x))
	items_changed.emit(items)

static func deserialize_from_dict(dict: Dictionary):
	var adventurer_resource = InventoryResource.new()
	adventurer_resource.deserialize(dict)
	return adventurer_resource

func _serialize_item(item: Item) -> Dictionary:
	if item == null:
		return {
			"is_null": true
		}
	else:
		var dict = item.serialize()
		dict["is_null"] = false
		return dict

func _deserialize_item(dict: Dictionary) -> Item:
	if dict["is_null"]:
		return null
	else:
		return _item_factory.item_table[dict["id"]]
