class_name SaveGameState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var _save_game_resource: SaveGameResource = SaveGameResource.new()
var _menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "save"
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func on_enter():
	var save_slot = _menu_save_resource.selected_saveslot
	_save_game_resource.write_savegame(save_slot)
	var timer = Timer.new()
	add_child(timer)
	timer.start(1)
	await timer.timeout
	transitioned.emit("game")
