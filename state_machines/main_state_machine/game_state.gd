class_name GameState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "game"
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func on_enter():
	_message_dispatcher.requested_save.connect(_on_save)
	_message_dispatcher.requested_exit_game.connect(_on_exit_game)


func on_exit():
	_message_dispatcher.requested_save.disconnect(_on_save)
	_message_dispatcher.requested_exit_game.disconnect(_on_exit_game)

func _on_save():
	transitioned.emit("save")

func _on_exit_game():
	transitioned.emit("save_and_exit")
