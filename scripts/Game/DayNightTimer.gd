extends Node2D
class_name DayNightTimer

@export var day_length = 60
@export var night_length = 60
@export var speed = 1.0
@export var min_day_time_hours = 6
@export var min_day_time_minutes = 0
@export var max_day_time_hours = 18
@export var max_day_time_minutes = 0

var current_day_time = 0.0
var current_hours: int
var current_minutes: int
var is_day = false

signal time_changed(is_day: bool, hours: int, minutes: int)
signal day_started
signal night_started
signal day_ended
signal night_ended

var timer: Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timeout)
	start_night_timer()

func _process(_delta: float):
	var remaining_time = timer.get_time_left()
	if is_day:
		current_day_time = (int((1-(remaining_time / day_length)) * 60 * 12) + min_day_time_hours * 60 + min_day_time_minutes) % (24 * 60)
	else:
		current_day_time = (int((1-(remaining_time / night_length)) * 60 * 12) + max_day_time_hours * 60 + max_day_time_minutes) % (24 * 60)
	current_hours = floor(current_day_time / 60)
	current_minutes = int(floor(current_day_time % 60))
	time_changed.emit(is_day, current_hours, current_minutes)

func start_day():
	start_day_timer()
	day_started.emit()


func start_night():
	start_night_timer()
	night_started.emit()


func start_day_timer():
	timer.start(day_length)


func start_night_timer():
	timer.start(night_length)


func _on_timeout():
	if is_day:
		is_day = false
		day_ended.emit()
		start_night()
	else:
		is_day = true
		night_ended.emit()
		start_day()
