class_name DungeonState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "dungeon"

func on_enter():
	get_tree().change_scene_to_file("res://Scenes/dungeon_game_scene.tscn")
	dnr.night_ended.connect(_on_night_ended)
	_message_dispatcher.requested_tavern_after_dungeon.connect(_on_taver_after_dungeon)

func on_exit():
	dnr.night_ended.disconnect(_on_night_ended)
	_message_dispatcher.requested_tavern_after_dungeon.disconnect(_on_taver_after_dungeon)

	
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_night_ended():
	transitioned.emit("day")
	get_tree().change_scene_to_file("res://Scenes/tavern_game_scene.tscn")

func _on_taver_after_dungeon():
	transitioned.emit("tavern_after_dungeon")
