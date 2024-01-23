extends Node2D
class_name NPCSpawner

@export var spawn_window_duration: float = 20
var adventurer_resource = preload("res://adventurer/adventurer.tscn")
var adventurer_strategy_map: Dictionary
var adventurers_to_spawn: Array
var timer: Timer
var time_table: Array
var index = 0
@export var movement_stats: MovementStats
var ai_resource = preload("res://Scenes/Game/Units/AIMovementMapper.tscn")


func _ready():
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(spawn_adventurer)
	add_child(timer)


func _create_time_table(duration: float, nr_of_chunks: int) -> Array:
	var table = []
	var equal_chunk_size = duration / (nr_of_chunks + 1)  # add plus 1 to be able to start with a break
	for i in range(nr_of_chunks):
		table.append(equal_chunk_size)
	return table

func spawn_adventurer() -> Adventurer:
	var resource = adventurers_to_spawn[index]
	var adventurer: Adventurer = adventurer_resource.instantiate()
	adventurer.adventurer_resource = resource
	var ai_movement_mapper = ai_resource.instantiate()
	ai_movement_mapper.set_actor(adventurer)
	ai_movement_mapper.movement_stats = self.movement_stats
	adventurer.set_ai_mapper(ai_movement_mapper)
	adventurer.ai_mapper.set_strategy(self.adventurer_strategy_map[resource])
	adventurer.unlink_material()
	add_child(adventurer)
	index += 1
	if index < len(time_table):
		timer.start(time_table[index])
	return adventurer

func set_adventurer_strategy_map(map: Dictionary):
	adventurer_strategy_map = map
	adventurers_to_spawn = map.keys()

func start_spawning():
	time_table = _create_time_table(spawn_window_duration, len(adventurer_strategy_map))
	index = 0
	timer.start(time_table[index])
