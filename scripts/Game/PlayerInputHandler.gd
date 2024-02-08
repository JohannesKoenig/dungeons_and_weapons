extends Node
class_name PlayerInputHandler

signal toggle_inventory
signal toggle_menu

func _process(delta):
	_handle_input()

func _handle_input():
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	if Input.is_action_just_pressed("Escape"):
		toggle_menu.emit()
