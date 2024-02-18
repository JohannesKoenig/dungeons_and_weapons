class_name TavernAfterDungeonState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "tavern_after_dungeon"

func on_enter():
	get_tree().change_scene_to_file("res://Scenes/tavern_game_scene.tscn")
	dnr.night_ended.connect(_on_night_ended)

func on_exit():
	dnr.night_ended.disconnect(_on_night_ended)
	
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_night_ended():
	transitioned.emit("day")
	
