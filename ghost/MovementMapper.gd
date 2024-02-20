class_name MovementMapper extends Node
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var parent: CharacterBody2D
var target: Node2D
@export var movement_stats: MovementStats
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	parent = get_parent()

func _process(delta):
	if _message_dispatcher.game_state is DeathState:
		return
	var dir = (target.global_position - parent.global_position).normalized()
	parent.velocity = dir * movement_stats.movement_speed

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

