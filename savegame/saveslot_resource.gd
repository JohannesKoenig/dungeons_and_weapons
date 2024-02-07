class_name SaveslotResource extends Resource
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var player_name: String
@export var slot: int
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func serialize() -> Dictionary:
	return {
		"player_name": player_name,
		"slot": slot
	}

func deserialize(data: Dictionary):
	print(data)
	player_name = data["player_name"]
	slot = data["slot"]
