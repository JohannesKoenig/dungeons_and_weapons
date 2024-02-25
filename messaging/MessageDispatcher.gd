class_name MessageDispatcher extends Resource
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var main_state:
	set(value):
		main_state = value
		main_state_changed.emit(value)
signal main_state_changed(state)

var loaded_game_state: String = "empty":
	set(value):
		loaded_game_state = value
		loaded_game_state_changed.emit(value)
signal loaded_game_state_changed(state: String)
var game_state:
	set(value):
		game_state = value
		game_state_changed.emit(value)
signal game_state_changed(state)

# Main Game and Menu requests
signal requested_load
signal requested_save
signal requested_exit_game
signal requested_game_over
signal finished_intro

#Ingame requests
signal requested_shop_open
signal requested_adventurer_return
signal requested_tavern_night
signal requested_tavern_day
signal requested_dungeon
signal requested_tavern_after_dungeon
signal requested_death
var shoppers_active: bool = false
var skip_intro: bool = false

var speed_up: bool = false:
	set(value):
		speed_up = value
		speed_up_changed.emit(value)
signal speed_up_changed(value: bool)

signal game_saved
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func serialize() -> Dictionary:
	var data = {}
	if game_state:
		data["game_state"] = game_state.get_state_name()
	else:
		data["game_state"] = "day"
	data["skip_intro"] = skip_intro
	return data
	

func deserialize(data: Dictionary):
	loaded_game_state = data["game_state"]
	skip_intro = data["skip_intro"]
