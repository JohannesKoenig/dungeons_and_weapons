extends Node


var input_type_resource: InputTypeResource = preload("res://Resources/input_type_resource.tres")

func _unhandled_input(event: InputEvent):
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		if !input_type_resource.is_controller:	
			input_type_resource.is_controller = true
			input_type_resource.is_keyboard = false
			input_type_resource.type_changed.emit()
		
	if event is InputEventKey or event is InputEventMouse:
		if !input_type_resource.is_keyboard:
			input_type_resource.is_controller = false
			input_type_resource.is_keyboard = true
			input_type_resource.type_changed.emit()
