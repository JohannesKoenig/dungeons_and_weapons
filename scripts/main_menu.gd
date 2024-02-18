extends Control

var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")

func _ready():
	
	menu_save_resource.load_savegame()
	if menu_save_resource.saveslot_resources.is_empty():
		$VBoxContainer/VBoxContainer/Start.visible = true
		$VBoxContainer/VBoxContainer/Start.grab_focus()
		$VBoxContainer/VBoxContainer/SaveExists.visible = false
	else:
		$VBoxContainer/VBoxContainer/Start.visible = false
		$VBoxContainer/VBoxContainer/SaveExists.visible = true
		$VBoxContainer/VBoxContainer/SaveExists/Continue.grab_focus()
		

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/new_save_menu.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits_menu.tscn")


func _on_button_pressed():
	menu_save_resource.delete(1)
	menu_save_resource.write_savegame()
	SaveGameResource.new().load_reset()
	$VBoxContainer/VBoxContainer/Start.visible = true
	$VBoxContainer/VBoxContainer/Start.grab_focus()
	$VBoxContainer/VBoxContainer/SaveExists.visible = false


func _on_continue_pressed():
	_message_dispatcher.requested_load.emit()
