class_name MessageDispatcher extends Resource
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var main_state:
	set(value):
		main_state = value
		main_state_changed.emit(value)
signal main_state_changed(state)

var loaded_game_state: String = "empty"
var game_state:
	set(value):
		game_state = value
		game_state_changed.emit(value)
signal game_state_changed(state)

# Main Game and Menu requests
signal requested_load
signal requested_save
signal requested_exit_game

#Ingame requests
signal requested_shop_open
signal requested_adventurer_return
signal requested_tavern_idle

var skip_intro: bool = false

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func serialize() -> Dictionary:
	return {
		"game_state": game_state.get_state_name(),
		"skip_intro": skip_intro
	}

func deserialize(data: Dictionary):
	loaded_game_state = data["game_state"]
	skip_intro = data["skip_intro"]
