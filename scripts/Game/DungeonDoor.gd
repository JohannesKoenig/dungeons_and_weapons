extends Node2D
class_name TavernDungeonDoor

@export var day_night_timer: DayNightResource
@export var dungeon_generator_resource: DungeonGeneratorResource = preload("res://dungeon_generator/dungeon_generator_resource.tres")
@export var dungeon_resource: DungeonResource = preload("res://dungeon_spawner/dungeon_resource.tres")
@export var player_resource: PlayerResource = preload("res://player/player_resource.tres")
@onready var game_saver : GameSaver = $"/root/GameSaver"
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
var is_open: bool = false
var is_night = false

func open():
	is_open = true

func close():
	is_open = false

func _on_actionable_action(source):
	if !day_night_timer.is_day and "player" in source.get_groups():
		game_saver.save_game_from_resources()
		get_tree().change_scene_to_file("res://Scenes/dungeon_game_scene.tscn")
	if source is Visitor and _message_dispatcher.game_state is ShopState:
		var resource: AdventurerResource = source.adventurer_resource
		resource.coins = max(0, resource.coins - 10)
		player_resource.set_coins(player_resource.coins + 10)
