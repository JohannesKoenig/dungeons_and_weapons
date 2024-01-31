extends Node
class_name PlayerInteractionMapper

var target: Player
@export var actionable_finder: ActionableFinder

func _ready():
	var parent = get_parent()
	if parent is Player:
		target = parent


func _process(delta: float):
	if Input.is_action_just_pressed("action"):
		if target:
			actionable_finder.interact(target)
