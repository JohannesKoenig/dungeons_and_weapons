extends Node2D

@export var dungeon_inventory: InventoryResource = preload("res://dungeon/dungeon_inventory.tres")
var customers_resource: CustomersResource = preload("res://customers/customers_resource.tres")


func _ready():
	var game_saver = get_node("/root/GameSaver")
	game_saver.load_game_from_resources()
	var drag_and_drop_layer = get_node("/root/DragAndDropLayer")
	drag_and_drop_layer.set_canvas_layer($CanvasLayer)
	var items_to_spawn = _get_items_to_spawn()
	dungeon_inventory.clear()
	for item in items_to_spawn:
		dungeon_inventory.add(item)
	# $ItemPickupSpawner.spawn_pickups()
	$DungeonSpawner.spawn_dungeon()


func _get_items_to_spawn() -> Array:
	var customers = customers_resource.today
	var all_items: Array = []
	for customer: AdventurerResource in customers:
		var customers_items = customer.inventory.items
		var no_null = customers_items.filter(func(x): return x != null)
		if randf() < 0.5:
			var item = no_null.pick_random()
			customer.inventory.remove(item)
			all_items.append(item)
	return all_items
