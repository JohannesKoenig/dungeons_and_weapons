extends StateMachine
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	if !("idle" in states):
		states["idle"] = _instantiate_state(load("res://state_machines/game_state_machine/idle_state.gd"))
	if !("return" in states):
		states["return"]= _instantiate_state(load("res://state_machines/game_state_machine/return_state.gd"))
	if !("shop" in states):
		states["shop"]= _instantiate_state(load("res://state_machines/game_state_machine/shop_state.gd"))
	_register_states()
	var loaded_game_state = _message_dispatcher.loaded_game_state
	if loaded_game_state == "empty":
		loaded_game_state = "idle"
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
func _get_state_by_name(name: String):
	match name:
		"idle": 
			for child in get_children():
				if child is IdleState:
					return child
			states["idle"] = _instantiate_state(load("res://state_machines/game_state_machine/idle_state.gd"))
			return states["idle"]
		"shop": 
			for child in get_children():
				if child is ShopState:
					return child
			states["shop"] = _instantiate_state(load("res://state_machines/game_state_machine/shop_state.gd"))
			return states["shop"]
		"return": 
			for child in get_children():
				if child is ReturnState:
					return child
			states["return"] = _instantiate_state(load("res://state_machines/game_state_machine/return_state.gd"))
			return states["return"]

