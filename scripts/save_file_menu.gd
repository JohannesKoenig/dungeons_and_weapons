extends Control

@onready var save_slot_1 = $VBoxContainer/HBoxContainer/SaveSlot1
@onready var save_slot_2 = $VBoxContainer/HBoxContainer/SaveSlot2
@onready var save_slot_3 = $VBoxContainer/HBoxContainer/SaveSlot3

var game_saver: GameSaver
var NR_SAVE_SLOTS = 3
var save_files: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	game_saver = get_node("/root/GameSaver")
	# load all save files
	if game_saver:
		var save_files = _load_save_files()
		for save_file in save_files:
			print(save_file)
			_on_save_file_loaded(save_file)
		

func _load_save_files() -> Array:
	var save_file_array = []
	for save_slot in range(NR_SAVE_SLOTS):
		save_file_array.append(game_saver.load_game(save_slot + 1))
	return save_file_array

func _on_save_file_loaded(save_file: SaveFile):
	if save_file:
		var slot = save_file.slot
		print(slot)
		print(save_file.name)
		match slot:
			1:
				save_slot_1.set_save_file(save_file)
			2:
				save_slot_2.set_save_file(save_file)
			3:
				save_slot_3.set_save_file(save_file)


func _on_new_pressed():
	get_tree().change_scene_to_file("res://Scenes/new_save_menu.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
