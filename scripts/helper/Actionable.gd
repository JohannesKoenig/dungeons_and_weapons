extends Area2D
class_name Actionable

var disabled = false
signal action

func trigger() -> void:
	if not disabled:
		action.emit()

func disable():
	disabled = true

func enable():
	disabled = false
