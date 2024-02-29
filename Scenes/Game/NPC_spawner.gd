extends Node2D
class_name NPCSpawner

@export var day_night_timer: DayNightResource
var dungeon_generator_resource: DungeonGeneratorResource = preload("res://dungeon_generator/dungeon_generator_resource.tres")
var spawn_window_duration: float
var visitor_resource = preload("res://visitor/visitor.tscn")
var adventurer_strategy_map: Dictionary
var adventurers_to_spawn: Array
var timer: Timer
var return_timer: Timer
var delay_timer: Timer
var time_table: Array
var index = 0
var return_index = 0
@export var movement_stats: MovementStats
var ai_resource = preload("res://Scenes/Game/Units/AIMovementMapper.tscn")
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
var return_strategy:Dictionary
@onready var ai_path_markers: AiPathMarkers = $"/root/AiPathMarkers"

var despawned_visitors: int = 0:
	set(value):
		despawned_visitors = value
		despawned_visitors_changed.emit()
signal despawned_visitors_changed

func _ready():
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(spawn_adventurer)
	add_child(timer)
	return_timer = Timer.new()
	return_timer.one_shot = true
	return_timer.timeout.connect(spawn_adventurer_return)
	add_child(return_timer)
	delay_timer = Timer.new()
	delay_timer.one_shot = true
	add_child(delay_timer)
	# _message_dispatcher.game_state_changed.connect(start_spawning_return)
	# start_spawning_return(_message_dispatcher.game_state)
	var resource = FileAccess.open("res://Resources/ai/return_strategy.json", FileAccess.READ)
	return_strategy = JSON.parse_string(resource.get_as_text())
	despawned_visitors_changed.connect(_on_all_returned)


func _create_time_table(duration: float, nr_of_chunks: int) -> Array:
	var table = []
	print(duration)
	var random_offset = 1
	var equal_chunk_size = duration / (nr_of_chunks + 1)  # add plus 1 to be able to start with a break
	print(equal_chunk_size)
	for i in range(nr_of_chunks-1):
		var offset = randf_range(-random_offset, random_offset)
		table.append(equal_chunk_size + offset)
	if nr_of_chunks > 0:
		table.append(equal_chunk_size + (-1) + randf_range(-random_offset, 0))
	return table

func spawn_adventurer() -> Visitor:
	_message_dispatcher.shoppers_active = true
	var resource = adventurers_to_spawn[index]
	var adventurer: Visitor = visitor_resource.instantiate()
	adventurer.set_adventurer_resource(resource)
	if _message_dispatcher.game_state is ReturnState:
		adventurer.set_strategy(return_strategy)
		add_child(adventurer)
		adventurer.global_position = ai_path_markers.position_register["despawn_position"].global_position
	else:
		adventurer.set_strategy(adventurer_strategy_map[resource])
		add_child(adventurer)
	adventurer.on_despawn.connect(_drops_item(resource))
	if _message_dispatcher.game_state is ShopState:
		adventurer.on_despawn.connect(_transition_to_return_state)
	index += 1
	if index < len(time_table):
		timer.start(time_table[index])
	else:
		if _message_dispatcher.game_state is ReturnState:
			_message_dispatcher.requested_tavern_night.emit()
	return adventurer

func spawn_adventurer_return() -> Visitor:
	var resource: AdventurerResource = adventurers_to_spawn[return_index].duplicate()
	resource.is_returning = true
	var adventurer: Visitor = visitor_resource.instantiate()
	adventurer.set_adventurer_resource(resource)
	adventurer.set_strategy(return_strategy)
	add_child(adventurer)
	adventurer.global_position = ai_path_markers.position_register["despawn_position"].global_position
	return_index += 1
	if return_index < len(time_table):
		return_timer.start(time_table[return_index])
	else:
		_message_dispatcher.requested_tavern_night.emit()
	return adventurer

func set_adventurer_strategy_map(map: Dictionary):
	adventurer_strategy_map = map
	adventurers_to_spawn = map.keys()
	adventurers_to_spawn.shuffle()

func start_spawning():
	var current_time = day_night_timer.current_day_time
	var end_day_time = (day_night_timer.sun_down_hour - 2) * 60 + day_night_timer.sun_down_minute
	var diff = end_day_time - current_time
	spawn_window_duration = (float(diff) / (12 * 60)) * (day_night_timer.day_time_length_in_seconds)
	time_table = _create_time_table(spawn_window_duration, len(adventurer_strategy_map))
	index = 0
	if len(time_table) > 0:
		timer.start(time_table[index])
	delay_timer.start(float(day_night_timer.day_length_in_seconds) / 5)
	await delay_timer.timeout
	start_spawning_return()

func start_spawning_return():
	dungeon_generator_resource.dropped_items = []
	#var diff = 2 * 60
	#spawn_window_duration = (float(diff) / (12 * 60)) * (day_night_timer.day_time_length_in_seconds)
	#time_table = _create_time_table(spawn_window_duration, len(adventurer_strategy_map))
	return_index = 0
	if len(time_table) > 0:
		return_timer.start(time_table[return_index])

func _on_all_returned():
	if despawned_visitors == len(time_table):
		if day_night_timer.is_day:
			await day_night_timer.day_ended
		_message_dispatcher.shoppers_active = false
		_message_dispatcher.requested_adventurer_return.emit()
		despawned_visitors = 0

func _transition_to_return_state():
	despawned_visitors += 1

func _drops_item(resource: AdventurerResource) -> Callable:
	return func():
		var dropped_item = randf() < 0.35
		if dropped_item:
			var item: Item = resource.inventory.items[0]
			if item:
				dungeon_generator_resource.dropped_items.append(item)
				resource.inventory.remove_at_index(0)
				var tween = create_tween()
				tween.tween_callback(func(): dungeon_generator_resource.item_dropped.emit(item)).set_delay(5)
				
