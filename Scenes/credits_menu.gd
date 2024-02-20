class_name CreditsMenu extends VBoxContainer
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var button_click_player
var init_ready = false

func _ready():
	button_click_player = $"/root/ButtonClick"
	$HBoxContainer/Button.grab_focus()
	init_ready = true

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_button_pressed():
	button_click_player.play_click()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_focus():
	if init_ready:
		button_click_player.play_focus()
