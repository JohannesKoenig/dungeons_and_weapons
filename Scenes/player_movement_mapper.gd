extends Node
class_name PlayerMovementMapper

@export var target: CharacterBody2D
@export var input: PlayerInputHandler
@export var movement_stats: MovementStats

func _process(delta):
	target.velocity = input.direction.normalized() * movement_stats.movement_speed
