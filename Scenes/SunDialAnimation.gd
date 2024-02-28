class_name SunDialAnimation extends AnimatedSprite2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")
var hour_offset = -6
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	dnr.time_changed.connect(_on_time_changed)
	_on_time_changed(dnr.is_day, dnr.current_hours, dnr.current_minutes)

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_time_changed(is_day: bool, hour: int, minute: int):
	var delta = hour + hour_offset
	if delta < 0:
		delta = delta - 1
	var div = int(float(delta) / 2)
	var sprite_index = (div + 12) % 12
	frame = sprite_index
