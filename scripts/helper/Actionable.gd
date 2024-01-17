extends Area2D
class_name Actionable

@export var actionable_name: String
var disabled = false
var middlewares: Array = []
signal action(message: Dictionary)

func _ready():
	for child in get_children():
		if child is ActionableMiddleware:
			middlewares.append(child)

func trigger(message: Dictionary = {}) -> void:
	for middleware in middlewares:
		message = middleware.interact(message)
	if not disabled:
		action.emit(message)

func disable():
	disabled = true

func enable():
	disabled = false
