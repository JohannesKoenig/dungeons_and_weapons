extends Node2D

@onready var shadows = $DirectionalLightShadows
@onready var light = $DirectionalLightSun
@export var sun_up_time_hour = 6
@export var sun_up_time_minute = 0
@export var sun_down_time_hour = 18
@export var sun_down_time_minute = 0
@export var shadow_light_energy = 1.42
@export var sun_light_energy = 0.89
@export var sun_up_duration = 2
@export var sun_down_duration = 2
@export var min_energy = 0.1

func on_daytime_changed(is_day: bool, hour: int, minute: int) -> void:
	var deg = lerp(0, 360, ((hour * 60 + minute)) / float((24) * 60))
	shadows.rotation_degrees = deg
	if is_day:
		shadows.energy = lerp(min_energy, shadow_light_energy, min(1,1-(((sun_up_time_hour + sun_up_duration) * 60 - (hour * 60 + minute))) / (float((sun_up_duration) * 60))))
		light.energy = lerp(min_energy, sun_light_energy, min(1,1-(((sun_up_time_hour + sun_up_duration) * 60 - (hour * 60 + minute))) / (float((sun_up_duration) * 60))))
	else:
		if hour >= sun_down_time_hour:
			shadows.energy = lerp(shadow_light_energy, min_energy, min(1,1-(((sun_down_time_hour + sun_down_duration) * 60 - (hour * 60 + minute))) / (float((sun_down_duration) * 60))))
			light.energy = lerp(sun_light_energy, min_energy, min(1,1-(((sun_down_time_hour + sun_down_duration) * 60 - (hour * 60 + minute))) / (float((sun_down_duration) * 60))))
		else:
			shadows.energy = min_energy
			light.energy = min_energy
