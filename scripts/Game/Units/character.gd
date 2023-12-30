extends CharacterBody2D
class_name Character

@export var target_delta = 1.0

@export var speed = 300.0
@onready var animation_tree = $AnimationTree

var direction: Vector2 = Vector2.ZERO
var view_direction: Vector2 = Vector2(1, 0)
var current_target_position: Vector2 = Vector2.ZERO

func _physics_process(delta):
	var current_position = get_position()
	var current_direction = current_target_position - current_position
	var current_distance = current_direction.length()
	if current_distance > target_delta:
		move(current_target_position - current_position)
	velocity.x = direction.x * speed
	velocity.y = direction.y * speed
	move_and_slide()
	update_animation()

func move(movement_direction: Vector2):
	direction = movement_direction.normalized()
	if direction != Vector2.ZERO:
		view_direction = direction

func move_to(point: Vector2):
	current_target_position = point

func update_animation():
	animation_tree.set("parameters/Idle/blend_position", view_direction)

