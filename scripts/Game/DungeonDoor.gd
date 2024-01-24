extends Node2D
class_name DungeonDoor

@export var day_night_timer: DayNightTimer
var is_open: bool = false
var is_night = false

func open():
	is_open = true

func close():
	is_open = false


func _on_actionable_action(message):
	if message:
		if !day_night_timer.is_day and "player" in message["source"].get_groups():
			get_tree().change_scene_to_file("res://Scenes/dungeon_game_scene.tscn")


