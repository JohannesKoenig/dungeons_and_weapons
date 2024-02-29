class_name CreditsMenu extends VBoxContainer
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var button_click_player
var init_ready = false
var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
@onready var highscore: Label = $Highscore

func _ready():
	button_click_player = $"/root/ButtonClick"
	$HBoxContainer/Button.grab_focus()
	init_ready = true
	if menu_save_resource.highscore > 0:
		highscore.text = "Highscore: %s days" % menu_save_resource.highscore
	else:
		highscore.text = "Highscore: - days"

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_button_pressed():
	button_click_player.play_click()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_focus():
	if init_ready:
		button_click_player.play_focus()
