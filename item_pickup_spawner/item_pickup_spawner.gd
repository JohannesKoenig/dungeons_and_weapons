class_name ItemPickupSpawner extends Node2D

var item_pickup_prototype = preload("res://item_pickup/item_pickup.tscn")
var dungeon_inventory: InventoryResource = preload("res://dungeon/dungeon_inventory.tres")

var _pickups: Array = []

func spawn_pickups():
	for index in range(dungeon_inventory.size):
		if dungeon_inventory.items[index]:
			var pickup: ItemPickup = item_pickup_prototype.instantiate()
			pickup.update_index(index)
			pickup.set_inventory(dungeon_inventory)
			add_child(pickup)
			pickup.position = Vector2(randf_range(-10,10), randf_range(-10,10))
			
		
