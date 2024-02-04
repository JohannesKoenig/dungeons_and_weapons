extends Node2D

var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")
var timer: Timer


func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timeout)
	start_night_timer()


func _process(_delta: float):
	var remaining_time = timer.get_time_left()
	if dnr.is_day:
		dnr.current_day_time = (int((1-(remaining_time / dnr.day_time_length_in_seconds)) * 60 * 12) + dnr.sun_up_hour * 60 + dnr.sun_up_minute) % (24 * 60)
	else:
		dnr.current_day_time = (int((1-(remaining_time / dnr.night_time_length_in_seconds)) * 60 * 12) + dnr.sun_down_hour * 60 + dnr.sun_down_minute) % (24 * 60)
	dnr.current_hours = floor(dnr.current_day_time / 60)
	dnr.current_minutes = int(floor(dnr.current_day_time % 60))
	dnr.time_changed.emit(dnr.is_day, dnr.current_hours, dnr.current_minutes)


func start_day_timer():
	timer.start(dnr.day_time_length_in_seconds)


func start_night_timer():
	timer.start(dnr.night_time_length_in_seconds)


func _on_timeout():
	if dnr.is_day:
		dnr.is_day = false
		dnr.day_ended.emit()
		start_night()
	else:
		dnr.is_day = true
		dnr.night_ended.emit()
		start_day()


func start_day():
	start_day_timer()
	dnr.day_started.emit()


func start_night():
	start_night_timer()
	dnr.night_started.emit()
