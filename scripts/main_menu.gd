extends Control

var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")

func _ready():
	$VBoxContainer/VBoxContainer/Start.grab_focus()
	menu_save_resource.load_savegame()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/save_file_menu.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits_menu.tscn")
