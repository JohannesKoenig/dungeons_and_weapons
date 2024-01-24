extends Camera2D

var tavern_open = false
@export var tavern_focus_position: Vector2 = Vector2(128,128)

func _on_tavern_game_scene_tavern_open_changed(value):
	tavern_open = value
	if tavern_open:
		global_position = tavern_focus_position
	else:
		global_position = get_parent().global_position
