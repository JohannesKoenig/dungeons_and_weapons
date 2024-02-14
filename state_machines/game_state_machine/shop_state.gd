class_name ShopState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func on_enter():
	_message_dispatcher.requested_adventurer_return.connect(_on_return)
	dnr.day_ended.connect(_on_return)
	if dnr.is_day == false:
		_on_return()

func on_exit():
	_message_dispatcher.requested_adventurer_return.disconnect(_on_return)
	
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

func _on_return():
	transitioned.emit("return")
