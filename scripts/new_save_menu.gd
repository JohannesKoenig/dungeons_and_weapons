extends Control

@export var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
@onready var name_input = $VBoxContainer/NameInput
@onready var skin_builder_gui: SkinBuilderGui = $VBoxContainer/SkinBuilderGui

var _skin_builder: SkinBuilder
var _save_slot: int = 1
var _name_text: String = ""
var button_click_player
var init_ready = false

func _ready():
	button_click_player = $"/root/ButtonClick"
	$VBoxContainer/HBoxContainer/Create.grab_focus()
	_skin_builder = SkinBuilder.new()
	init_ready = true


func _on_create_pressed():
	button_click_player.play_click()
	var save_slot_resource = SaveslotResource.new()
	save_slot_resource.player_name = _name_text
	save_slot_resource.slot = _save_slot
	var savegame_resource = SaveGameResource.new()
	savegame_resource.name = _name_text
	savegame_resource.slot = _save_slot
	savegame_resource.player_resource.head = _skin_builder.heads[skin_builder_gui.head_index]
	savegame_resource.player_resource.body = _skin_builder.bodies[skin_builder_gui.body_index]
	savegame_resource.player_resource.legs = _skin_builder.legs[skin_builder_gui.legs_index]
	savegame_resource.create_new_savegame(_save_slot)
	savegame_resource.write_savegame(_save_slot)
	menu_save_resource.saveslot_resources[_save_slot] = save_slot_resource
	menu_save_resource.write_savegame()
	_message_dispatcher.requested_load.emit()


func _on_back_pressed():
	button_click_player.play_click()
	menu_save_resource.write_savegame()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_name_input_text_changed(new_line: String):
	if init_ready:
		button_click_player.play_focus()
	_name_text = new_line
	if _name_text != "":
		$VBoxContainer/HBoxContainer/Create.disabled = false
	else:
		$VBoxContainer/HBoxContainer/Create.disabled = true

func _on_focus():
	if init_ready:
		button_click_player.play_focus()
