class_name GameOverState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "game_over"
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func on_enter():
	_message_dispatcher.requested_exit_game.connect(_on_exit_game)
	get_tree().change_scene_to_file("res://Scenes/game_over/game_over_scene.tscn")


func on_exit():
	_message_dispatcher.requested_exit_game.disconnect(_on_exit_game)


func _on_exit_game():
	menu_save_resource.delete(1)
	menu_save_resource.write_savegame()
	SaveGameResource.new().load_reset()
	transitioned.emit("menu")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
