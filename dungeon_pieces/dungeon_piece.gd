class_name DungeonPiece extends Node2D
# This class defines a piece of the dungeon beneath your tavern.
# The dungeon is generated by placing pieces next to each other.
# A DungeonPiece is mainly defined by the DungeonPieceResource parameter:
#   - tileset-layout
#   - tileset
#   - props-placement
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var dungeon_piece_resource: DungeonPieceResource:
	set(value):
		dungeon_piece_resource = value
		dungeon_piece_resource_changed.emit(value)
signal dungeon_piece_resource_changed(dungeon_piece_resource: DungeonPieceResource)

@onready var _tilemap: TileMap = $TileMap
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	_on_dungeon_piece_resource_changed(dungeon_piece_resource)
	dungeon_piece_resource_changed.connect(_on_dungeon_piece_resource_changed)
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_dungeon_piece_resource_changed(value: DungeonPieceResource):
	_on_tilemap_offset_changed(value.offset)
	value.offset_changed.connect(_on_tilemap_offset_changed)

func _on_tilemap_offset_changed(value: Vector2):
	_tilemap.position = value
