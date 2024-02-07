class_name DungeonPieceRule extends Resource
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var dungeon_piece: DungeonPieceResource
@export var N: Array = []
@export var W: Array = []
@export var E: Array = []
@export var S: Array = []
@export var edges: Dictionary = {
	"N": "wall",
	"W": "wall",
	"E": "wall",
	"S": "wall"
}

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

func serialize() -> Dictionary:
	return {
		"source": resource_path,
		"N": N.map(func(x): return x.resource_path),
		"W": W.map(func(x): return x.resource_path),
		"E": E.map(func(x): return x.resource_path),
		"S": S.map(func(x): return x.resource_path)
	}

func deserialize(dict: Dictionary):
	N = dict["N"].map(func(x): load(x))
	W = dict["W"].map(func(x): load(x))
	E = dict["E"].map(func(x): load(x))
	S = dict["S"].map(func(x): load(x))
