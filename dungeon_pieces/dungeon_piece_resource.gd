class_name DungeonPieceResource extends Resource
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var scene: PackedScene
@export var offset: Vector2: 
	set(value):
		offset = value
		offset_changed.emit(value)
signal offset_changed(offset: Vector2)
var depth: int = 0
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func serialize() -> Dictionary:
	return {
		"scene": scene.resource_path,
		"offset": {
			"x": offset.x,
			"y": offset.y
		}
	}

func deserialize(dict: Dictionary):
	scene = load(dict["scene"])
	offset = Vector2(dict["offset"]["x"], dict["offset"]["y"])

static func deserialize_from_dict(dict: Dictionary) -> DungeonPieceResource:
	var res = DungeonPieceResource.new()
	res.deserialize(dict)
	return res

func _to_string():
	return resource_path.split("_")[-1].split(".")[0]
