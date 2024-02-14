extends StateMachine
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	states = {
		"menu": _instantiate_state(load("res://state_machines/main_state_machine/menu_state.gd")),
		"load": _instantiate_state(load("res://state_machines/main_state_machine/load_game_state.gd")),
		"game": _instantiate_state(load("res://state_machines/main_state_machine/game_state.gd")),
		"save": _instantiate_state(load("res://state_machines/main_state_machine/save_game_state.gd")),
		"save_and_exit": _instantiate_state(load("res://state_machines/main_state_machine/save_and_exit_game_state.gd")),
	}
	_register_states()
	_on_transition("menu")

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
	_message_dispatcher.main_state = current_state
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
