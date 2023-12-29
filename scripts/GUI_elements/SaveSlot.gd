extends Control
class_name SaveSlot

@onready var icon = $VBoxContainer/Icon
@onready var name_label = $VBoxContainer/Name
@onready var load_button = $VBoxContainer/HBoxContainer/Load
@onready var delete_button = $VBoxContainer/HBoxContainer/Delete
@onready var new_button = $VBoxContainer/HBoxContainer/New

var _save_file: SaveFile

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
		new_button.visibile = false
	
	else:
		icon.texture = null
		name_label.text = ""
		load_button.visible = false
		delete_button.visible = false
		new_button.visibile = true
