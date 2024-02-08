class_name GameMenu extends VBoxContainer

var game_saver: GameSaver
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
signal deactivate
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	game_saver = get_node("/root/GameSaver")
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func activated(value: bool):
	if value:
		$Exit.grab_focus()

func _on_back_pressed():
	deactivate.emit()

func _on_exit_pressed():
	game_saver.save_game_from_resources()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
