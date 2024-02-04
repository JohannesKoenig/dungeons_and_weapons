class_name DungeonGeneratorResource extends Resource
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var rules: Dictionary = {}
@export var start_dungeon_piece_resource: DungeonPieceResource
var _UNKNOWN = 0
var _TODO = 1
var _DONE = 2

var pixel_width = 128
var pixel_height = 128
var x_width = 5
var y_width = 5
var start_x = 1
var start_y = 0
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func get_layout() -> Array:
	# generate "baseline"
	var options = []
	for x in range(x_width):
		for y in range(y_width):
			options.append(null)
	var all_tiles = rules.keys()
	for x in range(x_width):
		for y in range(x_width):
			options[_to_1D(x, y, x_width)] = all_tiles
	var collapsed = [start_dungeon_piece_resource]

	var processing_guide: Dictionary = {}
	processing_guide[_to_1D(start_x, start_y, x_width)] = {
		"status": _TODO,
		"source": collapsed
	}
	# propagate(start_x, start_y, x_count, options, processing_guide)
	var todos: Array = processing_guide.keys().filter(func(key): return processing_guide[key]["status"] == _TODO)
	while not todos.is_empty():
		var next_key = todos[0]
		var y = next_key % x_width
		var x = (next_key - y)/x_width
		propagate(x, y, x_width, y_width, options, processing_guide)
		todos = processing_guide.keys().filter(func(key): return processing_guide[key]["status"] == _TODO)

	var dungeon_layout = assemble(options,x_width,y_width)
	var pieces = []
	for x in range(x_width):
		for y in range(y_width):
			var piece_list = dungeon_layout[x * x_width + y]
			if len(piece_list) > 0:
				var piece: DungeonPieceResource = piece_list[0]
				var duplicated: DungeonPieceResource = piece.duplicate()
				duplicated.offset = Vector2(x * pixel_width, y * pixel_height)
				pieces.append(duplicated)
	return pieces
	

func assemble(options: Array, x_count: int, y_count: int) -> Array:
	
	var collapseable = _collapseable_indexes(options)
	while len(collapseable) > 0:
		var next_key = collapseable[0]
		var start_y = next_key % x_count
		var start_x = (next_key - start_y)/x_count
		# Start collapse:
		var collapsed = collapse_tile(start_x, start_y, x_count, options)
		# Propagate:
		var processing_guide: Dictionary = {}
		processing_guide[_to_1D(start_x, start_y, x_count)] = {
			"status": _TODO,
			"source": collapsed
		}
		# propagate(start_x, start_y, x_count, options, processing_guide)
		var todos: Array = processing_guide.keys().filter(func(key): return processing_guide[key]["status"] == _TODO)
		while not todos.is_empty():
			next_key = todos[0]
			var y = next_key % x_count
			var x = (next_key - y)/x_count
			propagate(x, y, x_count, y_count, options, processing_guide)
			todos = processing_guide.keys().filter(func(key): return processing_guide[key]["status"] == _TODO)
		collapseable = _collapseable_indexes(options)
		print(options.reduce(append_array_stateless, []).map(func(x): return x.scene.get_path()))
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
	return [array[_to_1D(x, y, x_max)].pick_random()]

func propagate(x: int, y: int, x_max: int, y_max: int, array: Array, processing_guide: Dictionary):
	var guide = processing_guide[_to_1D(x, y, x_max)]
	var source_options = guide["source"]
	var intersection = _intersect(source_options, array[_to_1D(x,y,x_max)])
	var prev = array[_to_1D(x,y,x_max)]
	processing_guide[_to_1D(x, y, x_max)] = {"status": _DONE}
	if len(prev) == len(intersection):
		# nothing happened => no propagation
		print("no changes for: " + str(x) + ", " + str(y))
		return
	array[_to_1D(x,y,x_max)] = intersection
	# N
	_add_todo(
		_to_1D(x, max(0,y-1), x_max), 
		processing_guide,
		array[_to_1D(x, y, x_max)]
			.map(func(x): return rules[x].N)
			.reduce(append_array_stateless, [])
	)
	# W
	_add_todo(
		_to_1D(max(0,x-1), y, x_max), 
		processing_guide,
		array[_to_1D(x, y, x_max)]
			.map(func(x): return rules[x].W)
			.reduce(append_array_stateless, [])
	)
	# E
	_add_todo(
		_to_1D(min(x_max-1,x+1), y, x_max), 
		processing_guide,
		array[_to_1D(x, y, x_max)]
			.map(func(x): return rules[x].E)
			.reduce(append_array_stateless, [])
	)
	# S
	_add_todo(
		_to_1D(x, min(y_max-1,y+1), x_max), 
		processing_guide,
		array[_to_1D(x, y, x_max)]
			.map(func(x): return rules[x].S)
			.reduce(append_array_stateless, [])
	)

func _add_todo(index: int, processing_guide: Dictionary, guide: Array):
	if not (index in processing_guide) or processing_guide[index]["status"] == _UNKNOWN:
		print("add guide for: " + str(index))
		processing_guide[index] = {
			"status": _TODO, 
			"source": guide
		}

func _intersect(arr1, arr2):
	var intersection = []
	for v in arr1:
		if v in arr2:
			intersection.append(v)
	return intersection

func append_array_stateless(accum, n): 
	accum.append_array(n)
	return accum
