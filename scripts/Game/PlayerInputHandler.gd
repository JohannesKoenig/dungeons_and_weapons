extends Node
class_name PlayerInputHandler

var vertical: float
var horizontal: float
var direction: Vector2
var is_action_just_pressed: bool

func _process(delta):
	_handle_input()

func _handle_input():
	vertical = Input.get_axis("up","down")
	horizontal = Input.get_axis("left", "right")
	direction = Vector2(horizontal, vertical)
	is_action_just_pressed = Input.is_action_just_pressed("action")
