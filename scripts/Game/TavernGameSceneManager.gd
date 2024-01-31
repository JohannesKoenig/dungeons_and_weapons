extends Node2D
class_name TavernManager

@export var max_adventurers_per_hour: int = 1
var ai_path_markers: AiPathMarkers
var interaction_middleware: InteractionMiddleware
var tavern_open = false
signal tavern_open_changed(value: bool)
var adventurer_resource_template = preload("res://adventurer/adventurer_resource.gd")
var adventurer_textures = [
	preload("res://art/sprites/character_commoner_skin.png"),
	preload("res://art/sprites/character_isolde_skin.png"),
	preload("res://art/sprites/character_mario_skin.png"),
	preload("res://art/sprites/texture_test.png"),
]
var rng: RandomNumberGenerator

func _ready():
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
	$CanvasLayer/TavernScene.set_quick_access_component($Entities/Player/QickAccessComponent)
	$CanvasLayer/TavernScene/InventoryPopUp.content.set_inventory_component($Entities/Player/InventoryComponent)
	$CanvasLayer/TavernScene/InventoryPopUp.content.set_quick_access_component($Entities/Player/QickAccessComponent)
	
	interaction_middleware = get_node("/root/InteractionMiddleware")
	$Entities/DayNightTimer.day_started.connect(
		interaction_middleware.day_starts
	)
	$Entities/DayNightTimer.night_started.connect(
		interaction_middleware.night_starts
	)
	tavern_open_changed.connect(trigger_ai_on_tavern_open)


func open_tavern(value: bool):
	if not value and not $Entities/DayNightTimer.is_day:
		tavern_open = value
		tavern_open_changed.emit(value)
	if value and $Entities/DayNightTimer.is_day:
		tavern_open = value
		tavern_open_changed.emit(value)

func toggle_tavern():
	open_tavern(!tavern_open)

func get_items_on_display() -> Array:
	return [
		_get_item_resource_and_marker($Entities/ItemDisplay),
		_get_item_resource_and_marker($Entities/ItemDisplay2),
		_get_item_resource_and_marker($Entities/ItemDisplay3),
		_get_item_resource_and_marker($Entities/ItemDisplay4),
		_get_item_resource_and_marker($Entities/ItemDisplay5),
		_get_item_resource_and_marker($Entities/ItemDisplay6),
	]

func get_adventurers() -> Array:
	var day_night_timer = $Entities/DayNightTimer
	var current_time = day_night_timer.current_day_time
	var end_day_time = day_night_timer.max_day_time_hours * 60 + day_night_timer.max_day_time_minutes
	var diff = end_day_time - current_time
	var diff_in_hours = float(diff) / 60
	var number_of_adventurers = rng.randi_range(0, diff_in_hours * max_adventurers_per_hour)
	var adventurers = []
	print(number_of_adventurers)
	for i in range(number_of_adventurers):
		var template = adventurer_resource_template.new()
		template.coins = 100
		template.texture = adventurer_textures.pick_random()
		adventurers.append(template)
	return adventurers

func trigger_ai_on_tavern_open(open: bool):
	if !open:
		return
	$Behaviours/AiDirector.update_instructions(
		get_items_on_display(),
		get_adventurers()
	)

func _get_item_resource_and_marker(item_display: ItemDisplay) -> Dictionary:
	return {
		"item": item_display.item_resource,
		"position": item_display.position_marker
	}
