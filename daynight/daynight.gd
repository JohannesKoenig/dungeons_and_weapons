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
var current_day_time: int = 0
var current_hours: int
var current_minutes: int
var current_seconds: int
var is_day: bool

signal time_changed(is_day: bool, hours: int, minutes: int)
signal day_started
signal night_started
signal day_ended
signal night_ended
