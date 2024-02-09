extends Node2D
class_name QuickAccessComponent

@export var quick_access_resource: QuickAccessResource
var selected_resource: Item
signal selected_changed(resource: Item)

func _ready():
	if quick_access_resource:
		select_by_index(quick_access_resource.selected_index)
		quick_access_resource.index_updated.connect(select_by_index)

func replace_item(target: Item, to_replace: Item) -> Item:
	return quick_access_resource.replace_item(target, to_replace)

func add_item_to_first_free_slot(item: Item) -> bool:
	return quick_access_resource.add_item_to_first_free_slot(item)

func add_item(item: Item, index: int) -> Item:
	var replaced = quick_access_resource.add_item(item, index)
	if index == quick_access_resource.selected_index:
		select_by_index(index)
	return replaced

func remove_item_at_index(index: int) -> Item:
	return quick_access_resource.remove_at_index(index)

func remove_item(item: Item) -> bool:
	return quick_access_resource.remove(item)

func select_by_index(index: int):
	selected_resource = quick_access_resource.inventory_resource.items[index]
	selected_changed.emit(selected_resource)
