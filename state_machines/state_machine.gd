class_name StateMachine extends Node
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var states: Dictionary = {}
var current_state: State
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _process(delta):
	if current_state:
		current_state.process()
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
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

func _instantiate_state(script: Script) -> Node:
	var node = Node.new()
	node.set_script(script)
	add_child(node)
	return node
