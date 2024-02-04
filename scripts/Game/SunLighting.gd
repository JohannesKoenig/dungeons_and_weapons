extends Node2D

@onready var canvas_modulate = $CanvasModulate
@export var dnr: DayNightResource
@export var dawn_color: Color
@export var noon_color: Color
@export var dusk_color: Color
@export var midnight_color: Color

var sun_up_time_hour
@export var sun_up_duration = 2

var sun_down_time_hour
@export var sun_down_duration = 2

var day_length: int
var night_length: int
var dawn_time: int
var noon_time: int
var dusk_time: int
var midnight_time: int

var initialized = false

func _ready():
	sun_up_time_hour = dnr.sun_up_hour
	sun_down_time_hour = dnr.sun_down_hour
	dnr.time_changed.connect(on_daytime_changed)
	day_length = sun_down_time_hour - sun_up_time_hour
	night_length = 24 - day_length
	dawn_time = sun_up_time_hour * 60
	noon_time = (sun_up_time_hour + day_length/2) * 60
	dusk_time = sun_down_time_hour * 60
	midnight_time = (sun_down_time_hour + night_length/2) * 60
	initialized = true

func on_daytime_changed(is_day: bool, hour: int, minute: int) -> void:
	if not initialized:
		return
	var time_in_minutes = hour * 60 + minute
	var color: Color
	
	# midnight -> dawn
	if (dawn_time - sun_up_duration/2 * 60) <= time_in_minutes and time_in_minutes < dawn_time:
		var delta = between((dawn_time - sun_up_duration/2 * 60), time_in_minutes, dawn_time)
		color = midnight_color.lerp(dawn_color, delta)
	
	# dawn -> noon
	elif dawn_time <= time_in_minutes and time_in_minutes < (dawn_time + sun_up_duration/2 * 60):
		var delta = between(dawn_time, time_in_minutes, (dawn_time + sun_up_duration/2 * 60))
		color = dawn_color.lerp(noon_color, delta)

	# noon
	elif (dawn_time + sun_up_duration/2 * 60) <= time_in_minutes and time_in_minutes < dusk_time:
		color = noon_color

	# noon -> dusk
	elif dusk_time <= time_in_minutes and time_in_minutes < (dusk_time + sun_down_duration/2 * 60):
		var delta = between(dusk_time, time_in_minutes, (dusk_time + sun_down_duration/2 * 60))
		color = noon_color.lerp(dusk_color, delta)

	# dusk -> midnight
	elif (dusk_time + sun_down_duration/2 * 60) <= time_in_minutes and time_in_minutes < (dusk_time + sun_down_duration * 60):
		var delta = between((dusk_time + sun_down_duration/2 * 60), time_in_minutes, (dusk_time + sun_down_duration * 60))
		color = dusk_color.lerp(midnight_color, delta)
	
	# midnight
	else:
		color = midnight_color
	
	canvas_modulate.color = color

func between(start: int, value: int, end: int) -> float:
	if value <= start:
		return 0
	if value >= end:
		return 1
	var duration = end - start
	var progress = float(value - start) / duration
	return progress

