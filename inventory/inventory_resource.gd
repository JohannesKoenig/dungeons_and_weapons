class_name InventoryResource
extends Resource

@export var size: int
@export var items: Array

signal items_changed(items: Array)

func _ready():
	# Initialize items-array
	if len(items) < size:
		var slots_to_create = size - len(items)
		for _i in range(slots_to_create):
			items.append(null)
		items_changed.emit(items)

func add(item) -> int:
	for i in range(len(items)):
		if items[i] == null:
			items[i] = item
			items_changed.emit(items)
			return i
	return -1

func add_at_position(item, index: int) -> bool:
	if items[index] == null:
		items[index] = item
		items_changed.emit(items)
		return true
	return false

func remove(item) -> bool:
	for i in range(len(items)):
		if items[i] == item:
			items[i] = null
			items_changed.emit(items)
			return true
	return false
		

func serialize() -> Dictionary:
	return {
		"size": size,
		"items": items.map(func(item): item.serialize())
	}

func deserialize(dict: Dictionary):
	size = dict["size"]
	items = dict["items"].map(func(item_dict): Item.new().deseri)
