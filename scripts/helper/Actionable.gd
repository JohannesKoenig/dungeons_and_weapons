extends Area2D
class_name Actionable

@export var actionable_name: String
signal action(source)

func trigger(source) -> void:
	action.emit(source)
