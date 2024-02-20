class_name BackgroundMusicPlayer extends AudioStreamPlayer
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var _menus_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
@export var fade_in_duration:float = 1.0
var _target_volume_db: float
var after_fade_in = false
var _music_bus = AudioServer.get_bus_index("Music")
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	_target_volume_db = volume_db
	volume_db = -80
	var length = stream.get_length()
	play(randf() * length / 2)
	var tween = create_tween()
	tween.tween_property(self, "volume_db", _target_volume_db, fade_in_duration)
	after_fade_in = true

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
