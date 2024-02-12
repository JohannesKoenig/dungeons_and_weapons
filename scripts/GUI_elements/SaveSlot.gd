extends Control
class_name SaveSlot

signal on_load_pressed
@export var saveslot_resource: SaveslotResource
@export var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
@onready var icon = $VBoxContainer/Icon
@onready var name_label = $VBoxContainer/Name
@onready var load_button = $VBoxContainer/HBoxContainer/Load
@onready var delete_button = $VBoxContainer/HBoxContainer/Delete
var game_saver: GameSaver
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")

func _ready():
	game_saver = $/root/GameSaver
	set_saveslot_resource(saveslot_resource)

func set_saveslot_resource(saveslot_resource: SaveslotResource):
	self.saveslot_resource = saveslot_resource
	_save_file_changed()

func _save_file_changed():
	# update layout
	if saveslot_resource:
		icon.texture = null  # set texture from _save_file (based on whatever decides the texture)
		name_label.text = saveslot_resource.player_name
		load_button.visible = true
		delete_button.visible = true
	else:
		icon.texture = null
		name_label.text = ""
		load_button.visible = false
		delete_button.visible = false


func _on_delete_pressed():
	menu_save_resource.remove_slot(saveslot_resource.slot)


func _on_load_pressed():
	menu_save_resource.selected_saveslot = saveslot_resource.slot
	_message_dispatcher.requested_load.emit()
	game_saver.save_slot = saveslot_resource.slot
	

func _on_saveslot_changed(saveslot: SaveslotResource):
	pass 
