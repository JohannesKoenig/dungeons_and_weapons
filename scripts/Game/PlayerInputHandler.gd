extends Node
class_name PlayerInputHandler

signal toggle_inventory


func _process(delta):
	_handle_input()

func _handle_input():
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()

