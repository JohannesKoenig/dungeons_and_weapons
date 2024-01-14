extends Node2D
class_name InventoryComponent

var inventory = []
@export var inventory_size = 16
signal inventory_changed(inventory: Array)

func _ready():
	# Initialize inventory with empty slots
	for i in range(inventory_size):
		inventory.append(null)
	add_item(load("res://Resources/weapons/curved_axe/weapon.tres"))

func add_item(item) -> bool:
	# Add item to first empty slot
	for i in range(inventory_size):
		if inventory[i] == null:
			inventory[i] = item
			inventory_changed.emit(inventory)
			return true
	return false

func add_item_at_index(item, index):
	var previous_item = inventory[index]
	inventory[index] = item
	inventory_changed.emit(inventory)
	return previous_item

func remove_item(item: ItemComponent) -> bool:
	# Remove item from inventory
	for i in range(inventory_size):
		if inventory[i] == item:
			inventory[i] = null
			inventory_changed.emit(inventory)
			return true
	return false

func get_item(index) -> ItemComponent:
	# Get item at index
	return inventory[index]

func get_item_count(item) -> int:
	# Get number of items in inventory
	var count = 0
	for i in range(inventory_size):
		if inventory[i] == item:
			count += 1
	return count

func get_item_index(item) -> int:
	# Get index of item in inventory
	for i in range(inventory_size):
		if inventory[i] == item:
			return i
	return -1
