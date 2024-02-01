extends Node2D

var day_night_resource: DayNightResource = preload("res://daynight/day_night_resource.tres")
var _dnr := day_night_resource
var timer: Timer


func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timeout)
	start_night_timer()


func _process(_delta: float):
	var remaining_time = timer.get_time_left()
	if _dnr.is_day:
		_dnr.current_day_time = (int((1-(remaining_time / _dnr.day_time_length_in_seconds)) * 60 * 12) + _dnr.sun_up_hour * 60 + _dnr.sun_up_minute) % (24 * 60)
	else:
		_dnr.current_day_time = (int((1-(remaining_time / _dnr.night_time_length_in_seconds)) * 60 * 12) + _dnr.sun_down_hour * 60 + _dnr.sun_down_minute) % (24 * 60)
	_dnr.current_hours = floor(_dnr.current_day_time / 60)
	_dnr.current_minutes = int(floor(_dnr.current_day_time % 60))
	_dnr.time_changed.emit(_dnr.is_day, _dnr.current_hours, _dnr.current_minutes)


func start_day_timer():
	timer.start(_dnr.day_time_length_in_seconds)


func start_night_timer():
	timer.start(_dnr.night_time_length_in_seconds)


func _on_timeout():
	if _dnr.is_day:
		_dnr.is_day = false
		_dnr.day_ended.emit()
		start_night()
	else:
		_dnr.is_day = true
		_dnr.night_ended.emit()
		start_day()


func start_day():
	start_day_timer()
	_dnr.day_started.emit()


func start_night():
	start_night_timer()
	_dnr.night_started.emit()
