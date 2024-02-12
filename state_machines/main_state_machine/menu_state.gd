class_name MenuState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "menu"
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func on_enter():
	print(_message_dispatcher)
	print(_on_load)
	_message_dispatcher.requested_load.connect(_on_load)

func on_exit():
	_message_dispatcher.requested_load.disconnect(_on_load)

func _on_load():
	transitioned.emit("load")
