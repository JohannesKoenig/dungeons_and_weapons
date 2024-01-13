extends Node
class_name PlayerInteractionMapper

@export var target: Adventurer
@export var input: PlayerInputHandler

func _process(delta: float):
	if input.is_action_just_pressed:
		target.interact()
