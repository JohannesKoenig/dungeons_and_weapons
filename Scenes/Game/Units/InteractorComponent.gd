extends Node2D
class_name InteractorComponent

@export var actionable_finder: ActionableFinder

func interact(message: Dictionary):
	var actionables = actionable_finder.get_overlapping_areas()
	if actionables.size() > 0:
		actionables[0].trigger(message)
