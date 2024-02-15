extends Area2D
class_name Actionable

@export var actionable_name: String
signal action(source)
var is_closest_to_player: bool = false:
	set(value):
		if is_closest_to_player != value:
			is_closest_to_player = value
			is_closest_to_player_changed.emit(value)
signal is_closest_to_player_changed(value: bool)

func closest_to_player(value: bool):
	is_closest_to_player = value

func trigger(source) -> void:
	action.emit(source)

func _process(delta):
	var overlapping = get_overlapping_areas()
	if overlapping.is_empty():
		closest_to_player(false)
