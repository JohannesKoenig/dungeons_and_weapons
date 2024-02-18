class_name FootstepsPlayer extends AudioStreamPlayer2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var tile_scanner: TileScanner
var footsteps = {
	"wood": [
		preload("res://audio/steps/wood/steps_wood_1.wav"),
		preload("res://audio/steps/wood/steps_wood_2.wav"),
		preload("res://audio/steps/wood/steps_wood_3.wav"),
		preload("res://audio/steps/wood/steps_wood_4.wav"),
		preload("res://audio/steps/wood/steps_wood_5.wav"),
		preload("res://audio/steps/wood/steps_wood_6.wav")
	],
	"stone": [
		preload("res://audio/steps/stone/steps_stone_1.wav"),
		preload("res://audio/steps/stone/steps_stone_2.wav"),
		preload("res://audio/steps/stone/steps_stone_3.wav"),
		preload("res://audio/steps/stone/steps_stone_4.wav"),
	],
	"grass": [
		preload("res://audio/steps/grass/steps_grass_1.wav"),
		preload("res://audio/steps/grass/steps_grass_2.wav"),
		preload("res://audio/steps/grass/steps_grass_3.wav"),
		preload("res://audio/steps/grass/steps_grass_4.wav"),
	],
	"dirt": [
		preload("res://audio/steps/grass/steps_grass_1.wav"),
		preload("res://audio/steps/grass/steps_grass_2.wav"),
		preload("res://audio/steps/grass/steps_grass_3.wav"),
		preload("res://audio/steps/grass/steps_grass_4.wav"),
	],
	"carpet": [
		preload("res://audio/steps/carpet/steps_carpet_1.wav"),
		preload("res://audio/steps/carpet/steps_carpet_2.wav"),
		preload("res://audio/steps/carpet/steps_carpet_3.wav"),
		preload("res://audio/steps/carpet/steps_carpet_4.wav"),
	]
}
var previous_material = "default"
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _process(delta):
	if previous_material != tile_scanner.floor_material:
		previous_material = tile_scanner.floor_material
		_change_sounds(tile_scanner.floor_material)

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

func _change_sounds(mat: String):
	var stream_length = stream.streams_count
	for i in range(stream_length):
		stream.remove_stream(0)
	if !(mat in footsteps):
		mat = "stone"
	var new_streams = footsteps[mat]
	for i in range(len(new_streams)):
		stream.add_stream(i, new_streams[i])
