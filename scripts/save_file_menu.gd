extends Control

@export var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
@onready var save_slot_1 = $VBoxContainer/HBoxContainer/SaveSlot1
@onready var save_slot_2 = $VBoxContainer/HBoxContainer/SaveSlot2
@onready var save_slot_3 = $VBoxContainer/HBoxContainer/SaveSlot3

func _ready():
	$VBoxContainer/HBoxContainer2/New.grab_focus()
	menu_save_resource.saveslot_resource_changed.connect(_on_saveslots_changed)
	menu_save_resource.load_savegame()

func _on_saveslots_changed(saveslots: Array):
	var slot_nodes = [save_slot_1, save_slot_2, save_slot_3]
	for node in slot_nodes:
		node.set_saveslot_resource(null)
	for saveslot in saveslots:
		var slot = saveslot.slot
		var node = slot_nodes[slot-1]
		node.set_saveslot_resource(saveslot)


func _on_new_pressed():
	menu_save_resource.write_savegame()
	get_tree().change_scene_to_file("res://Scenes/new_save_menu.tscn")


func _on_back_pressed():
	menu_save_resource.write_savegame()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
