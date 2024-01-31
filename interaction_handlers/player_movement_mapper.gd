extends Node
class_name PlayerMovementMapper

var target: CharacterBody2D
@export var movement_stats: MovementStats

var vertical: float
var horizontal: float
var direction: Vector2

var _direction_tween: Tween

func _ready():
	var parent = get_parent()
	if parent is CharacterBody2D:
		target = parent

func _process(delta):
	vertical = Input.get_axis("up","down")
	horizontal = Input.get_axis("left", "right")
	direction = Vector2(horizontal, vertical)
	if _direction_tween:
		_direction_tween.kill()
	
	_direction_tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	_direction_tween.tween_property(target, "velocity", direction.normalized() * movement_stats.movement_speed, movement_stats.acceleration_time)
