extends Control
class_name SaveSlot

signal on_load_pressed

@onready var icon = $VBoxContainer/Icon
@onready var name_label = $VBoxContainer/Name
@onready var load_button = $VBoxContainer/HBoxContainer/Load
@onready var delete_button = $VBoxContainer/HBoxContainer/Delete

var game_saver: GameSaver
var _save_file: SaveFile

func _ready():
	game_saver = $/root/GameSaver
	_save_file_changed()

func set_save_file(save_file: SaveFile):
	_save_file = save_file
	_save_file_changed()

func _save_file_changed():
	# update layout
	if _save_file:
		icon.texture = null  # set texture from _save_file (based on whatever decides the texture)
		name_label.text = _save_file.name
		load_button.visible = true
		delete_button.visible = true
	else:
		icon.texture = null
		name_label.text = ""
		load_button.visible = false
		delete_button.visible = false


func _on_delete_pressed():
	game_saver.delete_game(_save_file)
	set_save_file(null)


func _on_load_pressed():
	get_tree().change_scene_to_file("res://Scenes/tavern_game_scene.tscn")

