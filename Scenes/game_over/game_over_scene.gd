class_name GameOverScene extends Control

var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")

@onready var days: Label = $VBoxContainer/Days
@onready var highscore: Label = $VBoxContainer/Highscore
var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")
var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")

func _ready():
	days.text = str(dnr.day_counter) + " days"
	if dnr.day_counter > menu_save_resource.highscore:
		highscore.text = "New Highscore: %s" % dnr.day_counter
		menu_save_resource.highscore = dnr.day_counter
		menu_save_resource.write_savegame()
	else:
		highscore.text = "Highscore: %s" % menu_save_resource.highscore


func _on_exit_pressed():
	_message_dispatcher.requested_exit_game.emit()
