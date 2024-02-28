extends Node

var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
var timer: Timer
@export var running = false
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timeout)
	if running:
		if dnr.is_day:
			start_day_timer()
		else:
			start_night_timer()

func _bump_day():
	dnr.day_counter += 1

func _process(_delta: float):
	if !running or _message_dispatcher.game_state is DeathState:
		return
	var remaining_time = timer.get_time_left()
	dnr.remaining_time = remaining_time
	if dnr.is_day:
		dnr.current_day_time = (int((1-(remaining_time / dnr.day_time_length_in_seconds)) * 60 * 12) + dnr.sun_up_hour * 60 + dnr.sun_up_minute) % (24 * 60)
	else:
		var new_value = (int((1-(remaining_time / dnr.night_time_length_in_seconds)) * 60 * 12) + dnr.sun_down_hour * 60 + dnr.sun_down_minute) % (24 * 60) 
		if _passed_midnight(dnr.current_day_time, new_value):
			_bump_day()
		dnr.current_day_time = new_value

func _passed_midnight(old: int, new: int) -> bool:
	return (old > 0 ) and (new < old)

func start_day_timer():
	timer.start(dnr.remaining_time)

func start_night_timer():
	timer.start(dnr.remaining_time)

func _on_timeout():
	if dnr.is_day:
		dnr.is_day = false
		dnr.current_day_time = dnr.sun_down_hour * 60 + dnr.sun_down_minute
		dnr.remaining_time = dnr.night_time_length_in_seconds
		dnr.day_ended.emit()
		start_night()
	else:
		dnr.is_day = true
		dnr.current_day_time = dnr.sun_up_hour * 60 + dnr.sun_up_minute
		dnr.remaining_time = dnr.day_time_length_in_seconds
		dnr.night_ended.emit()
		start_day()


func start_day():
	start_day_timer()
	dnr.day_started.emit()


func start_night():
	start_night_timer()
	dnr.night_started.emit()
