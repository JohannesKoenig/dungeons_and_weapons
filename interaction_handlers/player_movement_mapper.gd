extends Node
class_name PlayerMovementMapper

var target: CharacterBody2D
@export var movement_stats: MovementStats
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")

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
	if !target:
		return
	if !(_message_dispatcher.game_state is ShopState or _message_dispatcher.game_state is DeathState):
		target.velocity = direction.normalized() * movement_stats.movement_speed
	else:
		target.velocity = Vector2.ZERO
