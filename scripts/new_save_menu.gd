extends Control

@export var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
@onready var name_input = $VBoxContainer/NameInput
@onready var save_slot_selection = $VBoxContainer/SlotSelection

var _save_slot: int = 1
var _name_text: String = ""


func _on_create_pressed():
	var save_slot_resource = SaveslotResource.new()
	save_slot_resource.player_name = _name_text
	save_slot_resource.slot = _save_slot
	menu_save_resource.saveslot_resources[_save_slot] = save_slot_resource
	menu_save_resource.write_savegame()
	get_tree().change_scene_to_file("res://Scenes/save_file_menu.tscn")


func _on_back_pressed():
	menu_save_resource.write_savegame()
	get_tree().change_scene_to_file("res://Scenes/save_file_menu.tscn")


func _on_slot_selection_item_selected(index):
	_save_slot = index + 1


func _on_name_input_text_changed():
	_name_text = name_input.text
