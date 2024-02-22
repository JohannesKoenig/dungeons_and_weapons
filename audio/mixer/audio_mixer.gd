extends Node
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var _music_bus = AudioServer.get_bus_index("Music")
var _ambient_bus = AudioServer.get_bus_index("Ambient")
var _combat_bus = AudioServer.get_bus_index("Combat")
var _ui_bus = AudioServer.get_bus_index("Ui")
var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	menu_save_resource.music_sound_level_changed.connect(_on_music_volume_changed)
	_on_music_volume_changed(menu_save_resource.music_sound_level)

	menu_save_resource.ambiant_sound_level_changed.connect(_on_ambient_volume_changed)
	_on_ambient_volume_changed(menu_save_resource.ambient_sound_level)

	menu_save_resource.combat_sound_level_changed.connect(_on_combat_volume_changed)
	_on_combat_volume_changed(menu_save_resource.combat_sound_level)
	
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_music_volume_changed(value: int):
	var multiplier = value / 100.0
	var vol = (0 - 30.0) * (1-multiplier)
	AudioServer.set_bus_volume_db(_music_bus, vol)
	if vol <= -30:
		AudioServer.set_bus_mute(_music_bus, true)
	else:
		AudioServer.set_bus_mute(_music_bus, false)

func _on_ambient_volume_changed(value: int):
	var multiplier = value / 100.0
	var vol = (0 - 30.0) * (1-multiplier)
	AudioServer.set_bus_volume_db(_ambient_bus, vol)
	if vol <= -30:
		AudioServer.set_bus_mute(_ambient_bus, true)
	else:
		AudioServer.set_bus_mute(_ambient_bus, false)

func _on_combat_volume_changed(value: int):
	var multiplier = value / 100.0
	var vol = (0 - 30.0) * (1-multiplier)
	var ui_vol = vol - 17
	AudioServer.set_bus_volume_db(_combat_bus, vol)
	AudioServer.set_bus_volume_db(_ui_bus, ui_vol)
	if vol <= -30:
		AudioServer.set_bus_mute(_combat_bus, true)
		AudioServer.set_bus_mute(_ui_bus, true)
	else:
		AudioServer.set_bus_mute(_combat_bus, false)
		AudioServer.set_bus_mute(_ui_bus, false)
