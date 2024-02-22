extends Node2D

@export var dungeon_inventory: InventoryResource = preload("res://dungeon/dungeon_inventory.tres")
var customers_resource: CustomersResource = preload("res://customers/customers_resource.tres")
@onready var dungeon_spawner: DungeonSpawner = $DungeonSpawner
@onready var item_pickup_spawner: ItemPickupSpawner = $ItemPickupSpawner
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
var dead = false

func _ready():
	var game_saver = get_node("/root/GameSaver")
	# game_saver.load_game_from_resources()
	var drag_and_drop_layer = get_node("/root/DragAndDropLayer")
	drag_and_drop_layer.set_canvas_layer($CanvasLayer)
	var items_to_spawn = _get_items_to_spawn()
	dungeon_inventory.clear()
	dungeon_spawner.spawn_dungeon()
	var spawning_pieces = dungeon_spawner.dungeon_pieces.filter(func(x): return len(x.spawn_area.polygon) >= 3)
	var spawn_points = []
	for item in items_to_spawn:
		dungeon_inventory.add(item)
		var piece: DungeonPiece = spawning_pieces.pick_random()
		var local_point = piece.spawn_area.get_random_point()
		var global_point = local_point + piece.dungeon_piece_resource.offset + dungeon_spawner.global_position
		spawn_points.append(global_point)
	item_pickup_spawner.spawn_pickups(spawn_points)
	_message_dispatcher.requested_death.connect(play_death_sound)
	
func play_death_sound():
	if !dead:
		$DeathSound.play()
		$BackgroundMusicPlayer.stop()
		dead = true


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
