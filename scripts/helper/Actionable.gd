extends Area2D
class_name Actionable

var disabled = false
signal action(message: Dictionary)

func trigger(message: Dictionary = {}) -> void:
	if not disabled:
		action.emit(message)

func disable():
	disabled = true

func enable():
	disabled = false
