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
	get_tree().change_scene_to_file("res://dungeon_transition_scene/dungeon_transition_scene.tscn")
	#dnr.night_ended.connect(_on_night_ended)
	_message_dispatcher.requested_tavern_after_dungeon.connect(_on_taver_after_dungeon)
	_message_dispatcher.requested_death.connect(_on_night_ended)

func on_exit():
	#dnr.night_ended.disconnect(_on_night_ended)
	_message_dispatcher.requested_tavern_after_dungeon.disconnect(_on_taver_after_dungeon)
	_message_dispatcher.requested_death.disconnect(_on_night_ended)

	
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_night_ended():
	transitioned.emit("death")

func _on_taver_after_dungeon():
	transitioned.emit("tavern_after_dungeon")
	get_tree().change_scene_to_file("res://Scenes/tavern_game_scene.tscn")
