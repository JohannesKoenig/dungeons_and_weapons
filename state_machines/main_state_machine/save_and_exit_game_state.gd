class_name SaveAndExitGameState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var _save_game_resource: SaveGameResource = SaveGameResource.new()
var _menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "save_and_exit"
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func on_enter():
	var save_slot = _menu_save_resource.selected_saveslot
	# _save_game_resource.write_savegame(save_slot)
	transitioned.emit("menu")
