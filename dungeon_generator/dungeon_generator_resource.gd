class_name DungeonGeneratorResource extends Resource
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var rules: Dictionary = {}
@export var start_dungeon_piece_resource: DungeonPieceResource
@export var wall_dungeon_piece_resource: DungeonPieceResource
var _UNKNOWN = 0
var _TODO = 1
var _DONE = 2

var _HALL = "hall"

var pixel_width = 128
var pixel_height = 128
var x_width = 7
var y_width = 7
var start_x = 3
var start_y = 1
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

# Known prblems:
# processing_guide should be list instead of dict: There shoud be duplicate keys allowed.

func get_layout() -> Array:
	# generate "baseline"
	var processing_guide: Array = []
	var options = []
	for x in range(x_width):
		for y in range(y_width):
			options.append(null)
	var all_tiles = rules.keys()
	for x in range(x_width):
		for y in range(x_width):
			options[_to_1D(x, y, x_width)] = all_tiles
	for x in range(x_width):
		for y in [0, y_width-1]:
			processing_guide.append({
				"index": _to_1D(x, y, x_width),
				"status": _TODO,
				"source": [wall_dungeon_piece_resource]
			})
	for x in [0, x_width-1]:
		for y in range(1, y_width-1):
			processing_guide.append({
				"index": _to_1D(x, y, x_width),
				"status": _TODO,
				"source": [wall_dungeon_piece_resource]
			})

	var collapsed = [start_dungeon_piece_resource]


	processing_guide.append({
		"index": _to_1D(start_x, start_y, x_width),
		"status": _TODO,
		"source": collapsed
	})
	# propagate(start_x, start_y, x_count, options, processing_guide)
	while not processing_guide.is_empty():
		var guide = processing_guide.pop_front()
		var next_key = guide["index"]
		var y = next_key % x_width
		var x = (next_key - y)/x_width
		propagate(x, y, x_width, y_width, options, guide, processing_guide)
	var dungeon_layout = assemble(options,x_width,y_width)
	# remove all unconnected dungeon pieces ----------
	var is_connected = get_connected_indexes(start_x, start_y, dungeon_layout)
	var is_connected_indexes = is_connected.map(func(x): return x["index"])
	var not_connected = range(0, len(options)).filter(func(i): return !(i in is_connected_indexes))
	for index in not_connected:
		dungeon_layout[index] = [wall_dungeon_piece_resource]
	# ------------------------------------------------
	var pieces = []
	for x in range(x_width):
		for y in range(y_width):
			var piece_list = dungeon_layout[x * x_width + y]
			if len(piece_list) > 0:
				var piece: DungeonPieceResource = piece_list[0]
				var duplicated: DungeonPieceResource = piece.duplicate()
				if !(piece == wall_dungeon_piece_resource):
					for elem in is_connected:
						if elem["index"] == _to_1D(x, y, x_width):
							duplicated.depth = elem["depth"]
							break
				else:
					duplicated.depth = -1
				duplicated.offset = Vector2(x * pixel_width, y * pixel_height)
				pieces.append(duplicated)
	return pieces

func get_connected_indexes(start_x: int, start_y: int, layout: Array) -> Array:
	var depth = 0
	var indexes = [
		{
			"index": _to_1D(start_x, start_y, x_width),
			"depth": depth
	}]
	var pieces = layout[_to_1D(start_x, start_y, x_width)]
	var rule: DungeonPieceRule = rules[pieces[0]]
	var processing_guide = {}
	processing_guide[_to_1D(start_x, start_y, x_width)] = {
			"status": _TODO
	}
	var open_processes = processing_guide.keys().filter(func(key): return processing_guide[key]["status"] == _TODO)
	while !open_processes.is_empty():
		depth += 1
		var index = open_processes[0]
		var y = index % x_width
		var x = (index - y)/x_width
		pieces = layout[_to_1D(x, y, x_width)]
		rule = rules[pieces[0]]
		processing_guide[_to_1D(x, y, x_width)] = {
			"status": _DONE
		}
		if rule.edges["N"] == _HALL and y-1 >= 0:
			var neightbour_index = _to_1D(x, y-1, x_width)
			if !(neightbour_index in processing_guide):
				indexes.append(
					{
						"index": neightbour_index,
						"depth": depth
					}
				)
				processing_guide[neightbour_index] = {
					"status": _TODO
				}
		if rule.edges["W"] == _HALL and x-1 >= 0:
			var neightbour_index = _to_1D(x-1, y, x_width)
			if !(neightbour_index in processing_guide):
				indexes.append(
					{
						"index": neightbour_index,
						"depth": depth
					}
				)
				processing_guide[neightbour_index] = {
					"status": _TODO
				}
		if rule.edges["E"] == _HALL and x+1 < x_width:
			var neightbour_index = _to_1D(x+1, y, x_width)
			if !(neightbour_index in processing_guide):
				indexes.append(
					{
						"index": neightbour_index,
						"depth": depth
					}
				)
				processing_guide[neightbour_index] = {
					"status": _TODO
				}
		if rule.edges["S"] == _HALL and y+1 < y_width:
			var neightbour_index = _to_1D(x, y+1, x_width)
			if !(neightbour_index in processing_guide):
				indexes.append(
					{
						"index": neightbour_index,
						"depth": depth
					}
				)
				processing_guide[neightbour_index] = {
					"status": _TODO
				}
		open_processes = processing_guide.keys().filter(func(key): return processing_guide[key]["status"] == _TODO)
	return indexes

func assemble(options: Array, x_count: int, y_count: int) -> Array:
	var collapseable = _collapseable_indexes(options)
	while len(collapseable) > 0:
		#print(options)
		var next_key = collapseable[0]
		var start_y = next_key % x_count
		var start_x = (next_key - start_y)/x_count
		# Start collapse:
		var collapsed = collapse_tile(start_x, start_y, x_count, options)
		#print("Collapsed to: " + str(collapsed))
		# Propagate:
		var processing_guide: Array = []
		processing_guide.append({
			"index": _to_1D(start_x, start_y, x_count),
			"status": _TODO,
			"source": collapsed
		})
		# propagate(start_x, start_y, x_count, options, processing_guide)
		while not processing_guide.is_empty():
			var guide = processing_guide.pop_front()
			next_key = guide["index"]
			var y = next_key % x_count
			var x = (next_key - y)/x_count
			propagate(x, y, x_count, y_count, options, guide, processing_guide)
		collapseable = _collapseable_indexes(options)
		# print(options.reduce(append_array_stateless, []).map(func(x): return x.scene.get_path()))
	return options

func _to_1D(x: int, y: int, x_max: int) -> int:
	return x * (x_max) + y

func _collapseable_indexes(array: Array) -> Array:
	var indexes = []
	for i in range(len(array)):
		if len(array[i]) > 1:
			indexes.append(i)
	return indexes


func collapse_tile(x: int, y: int, x_max: int, array: Array):
	var tile = [array[_to_1D(x, y, x_max)].pick_random()]
	return tile

func propagate(x: int, y: int, x_max: int, y_max: int, array: Array, guide: Dictionary, processing_guide: Array):
	var source_options: Array = guide["source"]
	#print(guide)
	if source_options.is_empty():
		#print("source empty, skip")
		return
	# print("source: " + str(source_options))
	#print("given: " + str(array[_to_1D(x,y,x_max)]))
	var intersection = _intersect(source_options, array[_to_1D(x,y,x_max)])
	# print("intersection: " + str(intersection))
	var prev = array[_to_1D(x,y,x_max)]
	#processing_guide[_to_1D(x, y, x_max)] = {"status": _DONE}
	#print("Intersection: " + str(intersection))
	#print("Prev: " + str(prev))
	if len(prev) == len(intersection):
		# nothing happened => no propagation
		# print("no changes for: " + str(x) + ", " + str(y))
		return
	array[_to_1D(x,y,x_max)] = intersection
	# N
	if y-1 >= 0:
		_add_todo(
			_to_1D(x, y-1, x_max), 
			processing_guide,
			array[_to_1D(x, y, x_max)]
				.map(func(x): return rules[x].N)
				.reduce(append_array_stateless, [])
		)
	# W
	if x-1 >= 0:
		_add_todo(
			_to_1D(x-1, y, x_max), 
			processing_guide,
			array[_to_1D(x, y, x_max)]
				.map(func(x): return rules[x].W)
				.reduce(append_array_stateless, [])
		)
	# E
	if x+1 < x_max:
		_add_todo(
			_to_1D(x+1, y, x_max), 
			processing_guide,
			array[_to_1D(x, y, x_max)]
				.map(func(x): return rules[x].E)
				.reduce(append_array_stateless, [])
		)
	# S
	if y+1 < y_max:
		_add_todo(
			_to_1D(x, y+1, x_max), 
			processing_guide,
			array[_to_1D(x, y, x_max)]
				.map(func(x): return rules[x].S)
				.reduce(append_array_stateless, [])
		)

func _add_todo(index: int, processing_guide: Array, guide: Array):
	processing_guide.append({
		"index": index,
		"status": _TODO, 
		"source": guide
	})

func _intersect(arr1, arr2):
	var intersection = []
	for v in arr1:
		if v in arr2:
			intersection.append(v)
	return intersection

func append_array_stateless(accum, n): 
	for elem in n:
		if !(elem in accum):
			accum.append(elem)
	return accum


func save_rules():
	var save_dict = {
		"rules": []
	}
	var base_path = "res://dungeon_pieces"
	var dir = DirAccess.open(base_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				var piece_name = file_name.trim_prefix("dungeon_piece_")
				var tres_name = base_path + "/" + file_name + "/" + "dungeon_piece_rule_" + piece_name + ".tres"
				var resource: DungeonPieceRule = load(tres_name)
				save_dict["rules"].append({
					"name": piece_name,
					"N": resource.N.map(func(x): return _resource_to_path(x)),
					"W": resource.W.map(func(x): return _resource_to_path(x)),
					"E": resource.E.map(func(x): return _resource_to_path(x)),
					"S": resource.S.map(func(x): return _resource_to_path(x)),
					"edges": resource.edges
				})
			file_name = dir.get_next()
		dir.list_dir_end()
	var file := FileAccess.open(base_path + "/" + "rules.json", FileAccess.WRITE)
	var json_string := JSON.new().stringify(save_dict)
	file.store_string(json_string)
	file.close()

func load_rules():
	rules = {}
	var base_path = "res://dungeon_pieces"
	var file := FileAccess.open(base_path + "/rules.json", FileAccess.READ)
	if !file:
		return
	var content = file.get_as_text()
	file.close()
	var data = JSON.parse_string(content)
	if !data:
		return

	for elem in data["rules"]:
		var path = base_path + "/dungeon_piece_" + elem["name"] + "/dungeon_piece_rule_" + elem["name"] + ".tres"
		var res: DungeonPieceRule = load(path)
		rules[res.dungeon_piece] = res
		#res.N = elem["N"].map(func(x): return load(x))
		#res.W = elem["W"].map(func(x): return load(x))
		#res.E = elem["E"].map(func(x): return load(x))
		#res.S = elem["S"].map(func(x): return load(x))
		res.N = []
		res.W = []
		res.E = []
		res.S = []
		res.edges = elem["edges"]
	
	for res in rules.keys():
		var rule_edge = rules[res].edges["N"]
		for other_res in rules.keys():
			var other_rule_edge = rules[other_res].edges["S"]
			if rule_edge == other_rule_edge:
				rules[res].N.append(other_res)
				rules[other_res].S.append(res)
		rule_edge = rules[res].edges["W"]
		for other_res in rules.keys():
			var other_rule_edge = rules[other_res].edges["E"]
			if rule_edge == other_rule_edge:
				rules[res].W.append(other_res)
				rules[other_res].E.append(res)
	
	

func _resource_to_path(resource: Resource) -> String:
	if resource:
		return resource.resource_path
	return ""
