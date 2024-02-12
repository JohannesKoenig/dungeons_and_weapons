class_name DayNightResource
extends Resource

# ------------------
# real world time
@export var day_length_in_seconds: int = 60
var day_time_length_in_seconds: int = day_length_in_seconds / 2
var night_time_length_in_seconds: int = day_length_in_seconds / 2
# ------------------
# ingame time
@export var sun_up_hour: int = 6
@export var sun_up_minute: int = 0
@export var sun_up_second: int = 0
@export var sun_down_hour: int = 18
@export var sun_down_minute: int = 0
@export var sun_down_second: int = 0

# ------------------
# computed values
var current_day_time: int = 360:
	set(value):
		current_hours = floor(value / 60)
		current_minutes = int(floor(value % 60))
		current_day_time = value
		time_changed.emit(is_day, current_hours, current_minutes)
var remaining_time: float = 30
var current_hours: int = 6
var current_minutes: int = 0
var is_day: bool = true

signal time_changed(is_day: bool, hours: int, minutes: int)
signal day_started
signal night_started
signal day_ended
signal night_ended

func serialize() -> Dictionary:
	return {
		"time": current_day_time,
		"is_day": is_day,
		"remaining_time": remaining_time
	}

func deserialize(data: Dictionary):
	is_day = data["is_day"]
	current_day_time = data["time"]
	remaining_time = data["remaining_time"]
