class_name DayState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "day"

func on_enter():
	_message_dispatcher.requested_shop_open.connect(_on_shop_open)
	dnr.day_ended.connect(_on_day_ended)
	

func on_exit():
	_message_dispatcher.requested_shop_open.disconnect(_on_shop_open)
	dnr.day_ended.disconnect(_on_day_ended)
	
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

func _on_shop_open():
	if dnr.is_day:
		transitioned.emit("shop")

func _on_day_ended():
	transitioned.emit("night")
