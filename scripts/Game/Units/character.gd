extends CharacterBody2D
class_name Character

const SPEED = 300.0
@onready var animation_tree = $AnimationTree

var direction: Vector2 = Vector2.ZERO
var view_direction: Vector2 = Vector2(1, 0)

func _physics_process(delta):
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED
	move_and_slide()
	update_animation()

func move(movement_direction: Vector2):
	direction = movement_direction.normalized()
	if direction != Vector2.ZERO:
		view_direction = direction

func update_animation():
	animation_tree.set("parameters/Idle/blend_position", view_direction)

