extends Area2D
class_name ActionableFinder

@export var source: Node
var closest_overlapping_area: Area2D

func _process(delta):
	_calculate_overlap()

func interact(source):
	print(closest_overlapping_area)
	if closest_overlapping_area and closest_overlapping_area.has_method("trigger"):
		closest_overlapping_area.trigger(source)


func _calculate_overlap():
	var areas = get_overlapping_areas()
	if len(areas) == 0:
		closest_overlapping_area = null
		return
	var with_dist = []
	for area in areas:
		var dist = (area.global_position - global_position).length()
		with_dist.append({"dist": dist, "area": area})
	with_dist.sort_custom(func(x, y): return x.dist <= y.dist)
	var closest_area = with_dist[0]["area"]
	if closest_area.has_method("closest_to_player"):
		if "player_actionable_finder" in get_groups():
			closest_area.closest_to_player(true)
		closest_overlapping_area = closest_area
	if "player_actionable_finder" in get_groups():
		for i in range(1, len(with_dist)):
			var area = with_dist[i]["area"]
			if area.has_method("closest_to_player"):
				area.closest_to_player(false)
