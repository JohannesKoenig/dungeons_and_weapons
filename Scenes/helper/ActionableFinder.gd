extends Area2D
class_name ActionableFinder

func interact(message: Dictionary = {}):
	var actionables = get_overlapping_areas()
	if actionables.size() > 0:
		var nearest = null
		var dist = INF
		for actionable in actionables:
			var current_dist = (actionable.global_position - global_position).length()
			if current_dist < dist:
				dist = current_dist
				nearest = actionable
		if nearest:
			nearest.trigger(message)
