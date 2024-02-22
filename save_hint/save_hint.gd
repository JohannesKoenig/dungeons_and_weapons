class_name SaveHint extends AnimatedSprite2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
var timer: Timer
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	_message_dispatcher.game_saved.connect(save)
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	visible = false

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func save():
	print("save")
	visible = true
	play()
	timer.start(2)
	await timer.timeout
	visible = false
	print("invisible")
