extends Node2D
class_name TavernDungeonDoor

@export var day_night_timer: DayNightResource
@export var dungeon_generator_resource: DungeonGeneratorResource = preload("res://dungeon_generator/dungeon_generator_resource.tres")
@export var dungeon_resource: DungeonResource = preload("res://dungeon_spawner/dungeon_resource.tres")
@onready var game_saver : GameSaver = $"/root/GameSaver"
var is_open: bool = false
var is_night = false

func open():
	is_open = true

func close():
	is_open = false

func _on_actionable_action(source):
	if !day_night_timer.is_day and "player" in source.get_groups():
		dungeon_generator_resource.save_rules()
		dungeon_generator_resource.load_rules()
		dungeon_generator_resource.save_rules()
		for res in dungeon_generator_resource.rules.keys():
			var rule = dungeon_generator_resource.rules[res]
		var pieces = dungeon_generator_resource.get_layout()
		dungeon_resource.dungeon_pieces = pieces
		game_saver.save_game_from_resources()
		get_tree().change_scene_to_file("res://Scenes/dungeon_game_scene.tscn")


