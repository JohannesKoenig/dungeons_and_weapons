extends Node2D
class_name ActionableMiddleware

var interaction_middleware: InteractionMiddleware
# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_middleware = get_node("/root/InteractionMiddleware")

func interact(message: Dictionary) -> Dictionary:
	if interaction_middleware == null:
		return message
	if "source" in message:
		if message["source"].get_groups().has("player"):
			if not interaction_middleware.day:
				return message
			else:
				return {}
	return message
