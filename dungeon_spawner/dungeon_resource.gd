class_name DungeonResource extends Resource
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var dungeon_pieces: Array:
	set(value):
		dungeon_pieces = value
		dungeon_pieces_changed.emit(value)
signal dungeon_pieces_changed(value: Array)
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func serialize() -> Dictionary:
	var pieces = []
	for dungeon_piece in dungeon_pieces:
		pieces.append(dungeon_piece.serialize())
	return {
		"dungeon_pieces": pieces
	}

func deserialize(dict: Dictionary):
	var pieces = []
	for dungeon_piece in dict["dungeon_pieces"]:
		var piece = DungeonPieceResource.deserialize_from_dict(dungeon_piece)
		pieces.append(piece)
	dungeon_pieces = pieces

