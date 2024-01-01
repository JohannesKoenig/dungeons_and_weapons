extends Node2D

@onready var character = $Character

# enum for general behaviour
var general_behaviour: int

# enum for action state
var action_state: int

var action_sequence: Array
var action_sequence_index: int = 0

var target_shelve: Array
var dir = Vector2.RIGHT
@export var spawn_position: Marker2D
@export var door_position: Marker2D
@export var dungeon_position: Marker2D
@export var hallway_position: Marker2D
@export var despawn_position: Marker2D
@export var store_position: Marker2D
@export var counter_position: Marker2D
@export var shelve_1_1_position: Marker2D
@export var shelve_1_2_position: Marker2D
@export var shelve_1_3_position: Marker2D
@export var shelve_2_1_position: Marker2D
@export var shelve_2_2_position: Marker2D
@export var shelve_2_3_position: Marker2D

# general behaviour
enum {
	SHOP,
	ONLY_DUNGEON
}

# action states
enum {
	SPAWN,
	DOOR, 
	HALLWAY,
	DUNGEON,
	DESPAWN,
	STORE,
	COUNTER,
	SHELVE_1_1,
	SHELVE_1_2,
	SHELVE_1_3,
	SHELVE_2_1,
	SHELVE_2_2,
	SHELVE_2_3,
}

func set_general_behaviour_shop(shelve: Array):
	general_behaviour = SHOP
	target_shelve = shelve
	action_sequence = get_action_sequence()
	action_sequence_index = 0
	action_state = action_sequence[action_sequence_index]

func set_general_behaviour_only_dungeon():
	general_behaviour = ONLY_DUNGEON
	action_sequence = get_action_sequence()
	action_sequence_index = 0
	action_state = action_sequence[action_sequence_index]

func get_action_sequence() -> Array:
	match general_behaviour:
		SHOP:
			return [SPAWN, DOOR, HALLWAY, STORE, _get_shelve_enum(target_shelve) , COUNTER, HALLWAY, DUNGEON, DESPAWN]	
		ONLY_DUNGEON:
			return [SPAWN, DOOR, HALLWAY, DUNGEON, DESPAWN]
	return []


func _ready():
	# TODO: remove this test
	set_general_behaviour_shop([1,3])
	_on_target_reached()
	character.reached_target.connect(_on_target_reached)


func _on_target_reached():
	var position = _get_position_by_action_state(action_state)
	if action_sequence_index < action_sequence.size() - 1:
		action_sequence_index += 1
		action_state = action_sequence[action_sequence_index]
	character.move_to(position)
	

func choose(array):
	array.shuffle()
	return array[0]


func _get_shelve_enum(shelve: Array) -> int:
	var i = shelve[0]
	var j = shelve[1]
	match i:
		1:
			match j:
				1:
					return SHELVE_1_1
				2:
					return SHELVE_1_2
				3:
					return SHELVE_1_3
		2:
			match j:
				1:
					return SHELVE_2_1
				2:
					return SHELVE_2_2
				3:
					return SHELVE_2_3
	return HALLWAY

func _get_position_by_action_state(action_state: int) -> Vector2:
	var position_dict = {
		SPAWN: spawn_position,
		DOOR: door_position,
		HALLWAY: hallway_position,
		DUNGEON: dungeon_position,
		DESPAWN: despawn_position,
		STORE: store_position,
		COUNTER: counter_position,
		SHELVE_1_1: shelve_1_1_position,
		SHELVE_1_2: shelve_1_2_position,
		SHELVE_1_3: shelve_1_3_position,
		SHELVE_2_1:shelve_2_1_position,
		SHELVE_2_2: shelve_2_2_position,
		SHELVE_2_3: shelve_2_3_position,
	}
	return position_dict[action_state].position
