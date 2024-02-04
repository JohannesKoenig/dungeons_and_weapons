class_name SpawnArea extends Polygon2D
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func get_random_point() -> Vector2:
	var vertices = Geometry2D.triangulate_polygon(polygon)
	var nr_of_triangles = len(vertices) / 3
	var triangle_index = randi_range(0, nr_of_triangles-1)
	var A = polygon[vertices[triangle_index * 3 + 0]]
	var B = polygon[vertices[triangle_index * 3 + 1]]
	var C = polygon[vertices[triangle_index * 3 + 2]]
	# A + AB * p + BC * q
	var q = randf()
	var p = randf()
	if (p + q) > 1:
		p = 1 - p
		q = 1 - q
	var x = A.x + (B.x - A.x) * p + (C.x - A.x) * q
	var y = A.y + (B.y - A.y) * p + (C.y - A.y) * q
	return Vector2(x,y)
