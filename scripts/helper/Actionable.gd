extends Area2D
class_name Actionable

@export var actionable_name: String
var disabled = false
signal action(message: Dictionary)

func trigger(message: Dictionary = {}) -> void:
	if not disabled:
		action.emit(message)

func disable():
	disabled = true

func enable():
	disabled = false
