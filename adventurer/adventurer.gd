extends CharacterBody2D
class_name Adventurer

@onready var actionable_finder: ActionableFinder = $Direction/ActionableFinder
@export var actionable_selector: Callable

func _physics_process(delta):
	move_and_slide()

func interact():
	actionable_finder.interact()
