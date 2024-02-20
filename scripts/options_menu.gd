extends Control

signal on_save
signal close
var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
var start_audio_values := {}
var button_click_player
var init_ready = false

func _ready():
	button_click_player = $"/root/ButtonClick"
	menu_save_resource.load_savegame()
	start_audio_values["ambient"] = menu_save_resource.ambient_sound_level
	start_audio_values["music"] = menu_save_resource.music_sound_level
	start_audio_values["combat"] = menu_save_resource.combat_sound_level
	$"VBoxContainer/HBoxContainer/save-button".grab_focus()
	init_ready = true

func _on_savebutton_pressed():
	button_click_player.play_click()
	menu_save_resource.write_savegame()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_backbutton_pressed():
	button_click_player.play_click()
	menu_save_resource.ambient_sound_level = start_audio_values["ambient"]
	menu_save_resource.music_sound_level = start_audio_values["music"]
	menu_save_resource.combat_sound_level = start_audio_values["combat"]
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_close():
	button_click_player.play_click()
	close.emit()

func _on_focus():
	if init_ready:
		button_click_player.play_focus()
