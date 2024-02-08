extends Node2D
class_name TavernManager

@export var customers_resource: CustomersResource
@export var dnr: DayNightResource
@export var tavern_resource: TavernResource = preload("res://tavern/tavern_resource.tres")
@export var max_adventurers_per_hour: int = 1
var ai_path_markers: AiPathMarkers
var adventurer_resource_template = preload("res://adventurer/adventurer_resource.gd")
var adventurer_textures = [
	preload("res://art/sprites/character_commoner_skin.png"),
	preload("res://art/sprites/character_isolde_skin.png"),
	preload("res://art/sprites/character_mario_skin.png"),
	preload("res://art/sprites/texture_test.png"),
]
var rng: RandomNumberGenerator
var game_saver: GameSaver

func _ready():
	game_saver = get_node("/root/GameSaver")
	game_saver.load_game_from_resources()
	dnr.day_ended.connect(game_saver.save_game_from_resources)
	dnr.day_ended.connect(func(): tavern_resource.open_tavern(false))
	rng = RandomNumberGenerator.new()
	ai_path_markers = get_node("/root/AiPathMarkers")
	if ai_path_markers:
		ai_path_markers.register_position("spawn_position", $Entities/Marker/SpawnPoint)
		ai_path_markers.register_position("door_position", $Entities/Marker/DoorPoint)
		ai_path_markers.register_position("hallway_position", $Entities/Marker/HallwayPoint)
		ai_path_markers.register_position("dungeon_position", $Entities/Marker/DungeonPoint)
		ai_path_markers.register_position("despawn_position", $Entities/Marker/DespawnPoint)
		ai_path_markers.register_position("store_position", $Entities/Marker/StorePoint)
		ai_path_markers.register_position("counter_position", $Entities/Marker/CounterPoint)
		ai_path_markers.register_position("shelve_1_1_position", $Entities/Marker/Shelve1Point1)
		ai_path_markers.register_position("shelve_1_2_position", $Entities/Marker/Shelve1Point2)
		ai_path_markers.register_position("shelve_1_3_position", $Entities/Marker/Shelve1Point3)
		ai_path_markers.register_position("shelve_2_1_position", $Entities/Marker/Shelve2Point1)
		ai_path_markers.register_position("shelve_2_2_position", $Entities/Marker/Shelve2Point2)
		ai_path_markers.register_position("shelve_2_3_position", $Entities/Marker/Shelve2Point3)
	
	var drag_and_drop_layer = get_node("/root/DragAndDropLayer")
	drag_and_drop_layer.set_canvas_layer($CanvasLayer)
	$CanvasLayer/TavernScene/InventoryPopUp.content.set_quick_access_component($Entities/Player/QickAccessComponent)
	tavern_resource.tavern_open_changed.connect(trigger_ai_on_tavern_open)


func get_items_on_display() -> Array:
	return [
		_get_item_resource_and_marker($Entities/ItemDisplay),
		_get_item_resource_and_marker($Entities/ItemDisplay2),
		_get_item_resource_and_marker($Entities/ItemDisplay3),
		_get_item_resource_and_marker($Entities/ItemDisplay4),
		_get_item_resource_and_marker($Entities/ItemDisplay5),
		_get_item_resource_and_marker($Entities/ItemDisplay6),
	]

func get_adventurers():
	var current_time = dnr.current_day_time
	var end_day_time = dnr.sun_down_hour * 60 + dnr.sun_down_minute
	var diff = end_day_time - current_time
	var diff_in_hours = float(diff) / 60
	var number_of_adventurers = rng.randi_range(diff_in_hours * max_adventurers_per_hour / 2, diff_in_hours * max_adventurers_per_hour)
	var res = customers_resource.get_random_cutstomers(number_of_adventurers)
	customers_resource.available.append_array(res["new"])
	customers_resource.today = res["adventurers"]

func trigger_ai_on_tavern_open(open: bool):
	if !open:
		return
	get_adventurers()
	$Behaviours/AiDirector.update_instructions()

func _get_item_resource_and_marker(item_display: ItemDisplay) -> Dictionary:
	return {
		"item": item_display.item_resource,
		"position": item_display.position_marker
	}
