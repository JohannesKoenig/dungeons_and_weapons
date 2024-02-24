extends Node2D
class_name TavernManager

@export var customers_resource: CustomersResource
@export var dnr: DayNightResource
@export var tavern_resource: TavernResource = preload("res://tavern/tavern_resource.tres")
var dungeon_generator_resource: DungeonGeneratorResource = preload("res://dungeon_generator/dungeon_generator_resource.tres")
var dungeon_resource: DungeonResource = preload("res://dungeon_spawner/dungeon_resource.tres")
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
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
var _master_bus = AudioServer.get_bus_index("Master")

var _is_speed_up = false

func _ready():
	AudioServer.remove_bus_effect(_master_bus, 0)
	dungeon_generator_resource.dropped_items = []
	game_saver = get_node("/root/GameSaver")
	# game_saver.load_game_from_resources()
	# dnr.day_ended.connect(game_saver.save_game_from_resources)
	dnr.day_ended.connect(func(): tavern_resource.open_tavern(false))
	dnr.day_ended.connect(_generate_dungeon)
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
	if dungeon_resource.dungeon_pieces.is_empty():
		var pieces = dungeon_generator_resource.get_layout()
		dungeon_resource.dungeon_pieces = pieces
	
	if _message_dispatcher.game_state is TavernAfterDungeonState:
		var pos = ai_path_markers.position_register["dungeon_position"].global_position
		$Entities/Player.global_position = pos
	
	_message_dispatcher.game_state_changed.connect(save)
	save(_message_dispatcher.game_state)

func _process(delta):
	if Input.is_action_just_pressed("action"):
		if _message_dispatcher.game_state is ShopState:
			if !_is_speed_up:
				_speed_up()
				_is_speed_up = true
			else:
				_speed_down()
				_is_speed_up = false

	if !(_message_dispatcher.game_state is ShopState):
		_speed_down()

func save(state: State):
	if state is DayState:
		SaveGameResource.new().write_savegame(1)
		_message_dispatcher.game_saved.emit()

func get_items_on_display() -> Array:
	return [
		_get_item_resource_and_marker($Entities/ItemDisplay),
		_get_item_resource_and_marker($Entities/ItemDisplay2),
		_get_item_resource_and_marker($Entities/ItemDisplay3),
		_get_item_resource_and_marker($Entities/ItemDisplay4),
		_get_item_resource_and_marker($Entities/ItemDisplay5),
		_get_item_resource_and_marker($Entities/ItemDisplay6),
	]


func _get_item_resource_and_marker(item_display: ItemDisplay) -> Dictionary:
	return {
		"item": item_display.item_resource,
		"position": item_display.position_marker
	}

func _generate_dungeon():
	dungeon_generator_resource.save_rules()
	dungeon_generator_resource.load_rules()
	dungeon_generator_resource.save_rules()
	#for res in dungeon_generator_resource.rules.keys():
		#var rule = dungeon_generator_resource.rules[res]
	var pieces = dungeon_generator_resource.get_layout()
	dungeon_resource.dungeon_pieces = pieces

func _speed_up():
	Engine.time_scale = 3

func _speed_down():
	Engine.time_scale = 1
