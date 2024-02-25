class_name SpeedUpHint extends Label
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	_message_dispatcher.game_state_changed.connect(_update_hint)
	_update_hint(_message_dispatcher.game_state)
	_message_dispatcher.speed_up_changed.connect(_update_speed_up)
	_update_speed_up(_message_dispatcher.speed_up)

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func faster():
	text = "faster"

func normal():
	text = "normal"

func show_hint():
	visible = true
	$InputHint.show_hint()

func hide_hint():
	visible = false
	$InputHint.hide_hint()

func _update_hint(state: State):
	if state is ShopState:
		show_hint()
	else:
		hide_hint()

func _update_speed_up(value: bool):
	if value:
		normal()
	else:
		faster()
