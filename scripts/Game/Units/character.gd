extends CharacterBody2D
class_name Character

@export var target_delta = 1.0

@export var speed = 300.0
@onready var animation_tree = $AnimationTree
signal reached_target
var reached_target_emitted = false

var current_state = IDLE
enum {
	WALKING,
	IDLE
}

var direction: Vector2 = Vector2.ZERO
var view_direction: Vector2 = Vector2.RIGHT
var current_target_position: Vector2

func _ready():
	current_target_position = global_position

func _physics_process(delta):
	var current_position = global_position
	var current_direction = current_target_position - current_position
	var current_distance = current_direction.length()
	if current_distance > target_delta:
		_move(current_target_position - current_position)
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		move_and_slide()
		update_animation()
	else:
		if not reached_target_emitted:
			reached_target_emitted = true
			current_state = IDLE
			reached_target.emit()

func _move(movement_direction: Vector2):
	current_state = WALKING
	direction = movement_direction.normalized()
	if direction != Vector2.ZERO:
		view_direction = direction

func move_to(point: Vector2):
	current_target_position = point
	reached_target_emitted = false

func update_animation():
	animation_tree.set("parameters/Idle/blend_position", Vector2(view_direction.x, 0.0))
	animation_tree.set("parameters/Walking/blend_position", direction)


