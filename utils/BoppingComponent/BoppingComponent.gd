class_name BoppingComponent extends Node

@export var offset: Vector2 = Vector2(0, -5)
@export var bopp_duration: float = 1.0
var _parent: Node2D
var _tween: Tween

func _ready():
	_parent = get_parent()
	_tween_up()


func _tween_up():
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(_parent, "position", _parent.position + offset, bopp_duration/2)
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.tween_callback(_tween_down)

func _tween_down():
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(_parent, "position", _parent.position - offset, bopp_duration/2)
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.tween_callback(_tween_up)
