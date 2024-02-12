class_name LoadGameState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var _save_game_resource: SaveGameResource = SaveGameResource.new()
var _menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "load"
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func on_enter():
	get_tree().change_scene_to_file("res://loading_screen/loading_scene.tscn")
	var save_slot = _menu_save_resource.selected_saveslot
	_save_game_resource.load_savegame(save_slot)
	var timer = Timer.new()
	add_child(timer)
	timer.start(1)
	await timer.timeout
	transitioned.emit("menu")
	
func on_exit():
	get_tree().change_scene_to_file("res://Scenes/tavern_game_scene.tscn")
