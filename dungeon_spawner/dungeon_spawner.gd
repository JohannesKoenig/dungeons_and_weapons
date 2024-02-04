class_name DungeonSpawner extends Node2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var dungeon_resource: DungeonResource
var dungeon_pieces = []
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func spawn_dungeon():
	dungeon_pieces = []
	var pieces = dungeon_resource.dungeon_pieces
	for piece: DungeonPieceResource in pieces:
		var scene: DungeonPiece = piece.scene.instantiate()
		dungeon_pieces.append(scene)
		scene.dungeon_piece_resource = piece
		add_child(scene)
