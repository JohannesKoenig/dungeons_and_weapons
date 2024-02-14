class_name GameMenu extends VBoxContainer

var game_saver: GameSaver
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
signal deactivate
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	game_saver = get_node("/root/GameSaver")
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func activated(value: bool):
	if value:
		$Exit.grab_focus()

func _on_back_pressed():
	deactivate.emit()

func _on_exit_pressed():
	_message_dispatcher.requested_exit_game.emit()
