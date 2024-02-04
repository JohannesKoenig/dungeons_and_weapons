extends Node2D

@export var dnr: DayNightResource
@export var shadow_color: Color
var sun_up_time_hour = 6
@export var sun_up_duration = 2

var sun_down_time_hour = 18
@export var sun_down_duration = 2

var day_length: int
var night_length: int
var dawn_time: int
var noon_time: int
var dusk_time: int
var midnight_time: int

var max_alpha

var initialized = false

func _ready():
	dnr.time_changed.connect(on_daytime_changed)
	sun_down_time_hour = dnr.sun_down_hour
	sun_up_time_hour = dnr.sun_up_hour
	if get_parent() is Sprite2D:
		$Sprite2D.texture = get_parent().texture
		var offset = get_parent().global_position - global_position
		$Sprite2D.position = offset + get_parent().offset
	day_length = sun_down_time_hour - sun_up_time_hour
	night_length = 24 - day_length
	dawn_time = sun_up_time_hour * 60
	noon_time = (sun_up_time_hour + day_length/2) * 60
	dusk_time = sun_down_time_hour * 60
	midnight_time = (sun_down_time_hour + night_length/2) * 60
	max_alpha = shadow_color.a
	initialized = true

func on_daytime_changed(is_day: bool, hour: int, minute: int) -> void:
	if not initialized:
		return
	var time_in_minutes = hour * 60 + minute
	var alpha: float
	var skew_degree: float
	
	# midnight -> dawn
	if (dawn_time - sun_up_duration/2 * 60) <= time_in_minutes and time_in_minutes < dawn_time:
		var delta = between((dawn_time - sun_up_duration/2 * 60), time_in_minutes, dawn_time)
		alpha = lerp(0.0,max_alpha/2,delta)
	
	# dawn -> noon
	elif dawn_time <= time_in_minutes and time_in_minutes < (dawn_time + sun_up_duration/2 * 60):
		var delta = between(dawn_time, time_in_minutes, (dawn_time + sun_up_duration/2 * 60))
		alpha = lerp(max_alpha/2,max_alpha,delta)

	# noon
	elif (dawn_time + sun_up_duration/2 * 60) <= time_in_minutes and time_in_minutes < dusk_time:
		alpha = max_alpha

	# noon -> dusk
	elif dusk_time <= time_in_minutes and time_in_minutes < (dusk_time + sun_down_duration/2 * 60):
		var delta = between(dusk_time, time_in_minutes, (dusk_time + sun_down_duration/2 * 60))
		alpha = lerp(max_alpha,max_alpha/2,delta)

	# dusk -> midnight
	elif (dusk_time + sun_down_duration/2 * 60) <= time_in_minutes and time_in_minutes < (dusk_time + sun_down_duration * 60):
		var delta = between((dusk_time + sun_down_duration/2 * 60), time_in_minutes, (dusk_time + sun_down_duration * 60))
		alpha = lerp(max_alpha/2,0.0,delta)
	
	# midnight
	else:
		alpha = 0.0
	
	# skew shadow
	if (dawn_time - sun_up_duration/2 * 60) <= time_in_minutes and time_in_minutes < (dusk_time + sun_down_duration * 60):
		var delta = between((dawn_time - sun_up_duration/2 * 60), time_in_minutes, (dusk_time + sun_down_duration * 60))
		skew_degree = lerp(40,-40, delta)
	shadow_color.a = alpha
	skew = deg_to_rad(skew_degree)
	modulate = shadow_color
	
func between(start: int, value: int, end: int) -> float:
	if value <= start:
		return 0
	if value >= end:
		return 1
	var duration = end - start
	var progress = float(value - start) / duration
	return progress
