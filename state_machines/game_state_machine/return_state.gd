class_name ReturnState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "return"

func on_enter():
	_message_dispatcher.requested_tavern_night.connect(_on_idle)

func process():
	transitioned.emit("night")

func on_exit():
	_message_dispatcher.requested_tavern_night.disconnect(_on_idle)
	
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

func _on_idle():
	transitioned.emit("night")
