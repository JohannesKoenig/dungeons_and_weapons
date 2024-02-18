class_name Ghost extends CharacterBody2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var target: Node2D
@export var damage: int = 1
var bounce_velocity: Vector2
var recall_duration = 1.0
var start_time: float
var timer: Timer
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	$MovementMapper.target = target
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true

func _physics_process(delta):
	var bounce_to_add = Vector2.ZERO
	if not timer.is_stopped():
		bounce_to_add = lerp(bounce_velocity, Vector2.ZERO, 1-timer.time_left/recall_duration)
	var collision = move_and_collide((velocity + 6*bounce_to_add) * delta)
	var collision_count = 0
	if collision:
		var collider = collision.get_collider()
		if collider is Player:
			collider.take_damage(damage)
		var normal = collision.get_normal()
		bounce_velocity = velocity.bounce(normal)
		timer.start(recall_duration)
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

