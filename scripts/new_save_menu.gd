extends Control

var game_saver: GameSaver
@onready var name_input = $VBoxContainer/NameInput
var save_slot: int = 1
var name_text: String = ""
@onready var save_slot_selection = $VBoxContainer/SlotSelection

func _ready():
	game_saver = $/root/GameSaver


func _on_create_pressed():
	game_saver.save_game(save_slot, name_text)
	get_tree().change_scene_to_file("res://Scenes/save_file_menu.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/save_file_menu.tscn")



func _on_slot_selection_item_selected(index):
	save_slot = index + 1


func _on_name_input_text_changed():
	name_text = name_input.text
