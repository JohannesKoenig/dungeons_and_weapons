extends StateMachine
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	if !("day" in states):
		states["day"] = _instantiate_state(load("res://state_machines/game_state_machine/day_state.gd"))
	if !("night" in states):
		states["night"] = _instantiate_state(load("res://state_machines/game_state_machine/night_state.gd"))
	if !("return" in states):
		states["return"]= _instantiate_state(load("res://state_machines/game_state_machine/return_state.gd"))
	if !("shop" in states):
		states["shop"]= _instantiate_state(load("res://state_machines/game_state_machine/shop_state.gd"))
	_register_states()
	var loaded_game_state = _message_dispatcher.loaded_game_state
	if loaded_game_state == "empty":
		loaded_game_state = "day"
	_on_transition(loaded_game_state)

func _register_states():
	for key in states:
		var state:State = states[key]
		state.transitioned.connect(_on_transition)

func _on_transition(next: String):
	if !(next in states):
		return
	var next_state = states[next]
	if current_state:
		current_state.on_exit()
	next_state.on_enter()
	current_state = next_state
	_message_dispatcher.game_state = current_state

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------