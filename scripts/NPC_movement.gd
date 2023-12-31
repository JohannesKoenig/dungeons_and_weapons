extends CharacterBody2D

@onready var character = $Character
@export var walking_distance = 30
var current_state = DUNGEON
var dir = Vector2.RIGHT
@export var start_position: Marker2D
@export var door_target: Marker2D
@export var dungeon_target: Marker2D

enum {
	SPAWN,
	DOOR, 
	DUNGEON
}

func _ready():
	_on_target_reached()
	character.reached_target.connect(_on_target_reached)


func _on_target_reached():
	print("target reached: %s" % current_state)
	match current_state:
		SPAWN:
			character.move_to(door_target.position)
			current_state = DOOR
			return
		DOOR:
			character.move_to(dungeon_target.position)
			current_state = DUNGEON
			return
		DUNGEON:
			character.move_to(start_position.position)
			current_state = SPAWN
			return

func choose(array):
	array.shuffle()
	return array[0]
