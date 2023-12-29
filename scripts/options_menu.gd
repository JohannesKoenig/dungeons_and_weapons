extends Control

func _on_savebutton_pressed():
	# TODO: save audio settings
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_backbutton_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
