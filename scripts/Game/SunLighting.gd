extends Node2D

@onready var shadows = $DirectionalLightShadows
@onready var light = $DirectionalLightSun
@export var min_angle = 90.0
@export var max_angle = 270.0
@export var sun_up_time_hour = 6
@export var sun_up_time_minute = 0
@export var sun_down_time_hour = 18
@export var sun_down_time_minute = 0
@export var shadow_light_energy = 1.42
@export var sun_light_energy = 0.89

func on_daytime_changed(is_day: bool, hour: int, minute: int) -> void:
	if is_day and hour >= sun_up_time_hour and hour < sun_down_time_hour:
		shadows.energy = shadow_light_energy
		light.energy = sun_light_energy
		shadows.rotate(deg_to_rad(lerp(min_angle, max_angle, (hour - sun_up_time_hour) / (sun_down_time_hour - sun_up_time_hour))))
	else:
		shadows.energy = 0.0
		light.energy = 0.0
		shadows.rotate(min_angle)
