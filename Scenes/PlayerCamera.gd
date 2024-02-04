extends Camera2D

@export var tavern_resource: TavernResource = preload("res://tavern/tavern_resource.tres")
@export var tavern_focus_position: Vector2 = Vector2(128,128)

func _ready():
	tavern_resource.tavern_open_changed.connect(_on_tavern_game_scene_tavern_open_changed)
	_on_tavern_game_scene_tavern_open_changed(tavern_resource.open)

func _on_tavern_game_scene_tavern_open_changed(value):
	if value:
		global_position = tavern_focus_position
	else:
		global_position = get_parent().global_position
