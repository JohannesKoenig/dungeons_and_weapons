class_name NightState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "night"

func on_enter():
	dnr.night_ended.connect(_on_night_ended)
	_message_dispatcher.requested_dungeon.connect(_on_requested_dungeon)

func on_exit():
	dnr.night_ended.disconnect(_on_night_ended)
	_message_dispatcher.requested_dungeon.disconnect(_on_requested_dungeon)
	
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_night_ended():
	transitioned.emit("day")

func _on_requested_dungeon():
	transitioned.emit("dungeon")
