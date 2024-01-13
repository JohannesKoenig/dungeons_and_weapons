extends CharacterBody2D
class_name Adventurer

@onready var actionable_finder: ActionableFinder = $Direction/ActionableFinder
@export var actionable_selector: Callable
@export var item_resource: Resource

func _physics_process(delta):
	move_and_slide()

func interact():
	actionable_finder.interact({
		"item_resource": item_resource
	})
