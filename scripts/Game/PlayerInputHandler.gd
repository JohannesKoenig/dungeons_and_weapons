extends Node
class_name PlayerInputHandler

signal toggle_inventory

var vertical: float
var horizontal: float
var direction: Vector2
var is_action_just_pressed: bool

var tavern_open = false

func _process(delta):
	_handle_input()

func _handle_input():
	if !tavern_open:
		vertical = Input.get_axis("up","down")
		horizontal = Input.get_axis("left", "right")
		direction = Vector2(horizontal, vertical)
		is_action_just_pressed = Input.is_action_just_pressed("action")
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()

func _on_tavern_open_changed(open: bool):
	tavern_open = open
