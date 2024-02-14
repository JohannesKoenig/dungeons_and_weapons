class_name StateMachine extends Node
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var states: Dictionary = {}
var current_state: State
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _process(delta):
	if current_state:
		current_state.process()
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

func _instantiate_state(script: Script) -> Node:
	var node = Node.new()
	node.set_script(script)
	add_child(node)
	return node
