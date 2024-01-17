extends Node2D
class_name QuickAccessComponent

@export var size = 10
@export var selected: int = 0
var selected_resource: WeaponResource
signal selected_changed(resource: WeaponResource)
signal items_changed(items: Array)

var items: Array

func _ready():
	items = []
	for i in range(size):
		items.append(null)
	select_by_index(selected)

func replace_item(target: WeaponResource, to_replace: WeaponResource) -> WeaponResource:
	for index in range(size):
		if items[index] == target:
			return add_item(to_replace, index)
	return null


func add_item(item: WeaponResource, index: int) -> WeaponResource:
	var item_to_return = items[index]
	items[index] = item
	items_changed.emit(items)
	if index == selected:
		select_by_index(index)
	return item_to_return 

func remove_item_at_index(index: int) -> WeaponResource:
	items_changed.emit(items)
	return add_item(null, index)

func remove_item(item: WeaponResource) -> bool:
	for index in range(size):
		if items[index] == item:
			items[index] = null
			items_changed.emit(items)
			if index == selected:
				select_by_index(index)
			return true
	return false

func select_by_index(index: int):
	selected_resource = items[index]
	selected_changed.emit(selected_resource)
