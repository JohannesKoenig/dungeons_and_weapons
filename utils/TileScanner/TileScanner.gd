class_name TileScanner extends Node2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var _tile_maps: Array = []
var floor_material: String = "default"
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	_tile_maps = get_tree().get_nodes_in_group("floor_tiles")
	get_tree().node_added.connect(_on_node_added)

func _process(delta):
	_get_tile()
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _get_tile():
	for tile_map: TileMap in _tile_maps:
		var pos = tile_map.to_local(global_position)
		var coords = tile_map.local_to_map(pos)
		var tile = tile_map.get_cell_tile_data(0, coords)
		if tile:
			floor_material = tile.get_custom_data("material")
		else:
			"default"

func _on_node_added(node: Node):
	if node.is_in_group("floor_tiles"):
		_tile_maps.append(node)
