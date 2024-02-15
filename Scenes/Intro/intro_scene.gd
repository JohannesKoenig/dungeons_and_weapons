class_name IntroScene extends Node2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var ai_path_markers: AiPathMarkers

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	ai_path_markers = get_node("/root/AiPathMarkers")
	if ai_path_markers:
		ai_path_markers.register_position("door_position", $Entities/Marker/DoorPoint)
		ai_path_markers.register_position("hallway_position", $Entities/Marker/HallwayPoint)
		ai_path_markers.register_position("player_intro_spawn_position", $Entities/Marker/PlayerIntroSpawnPoint)
		ai_path_markers.register_position("player_conversation_position",  $Entities/Marker/PlayerConversationPoint)
		ai_path_markers.register_position("major_intro_spawn_position", $Entities/Marker/MajorIntroSpawnPoint)
		ai_path_markers.register_position("major_conversation_position",  $Entities/Marker/MajorConversationPoint)

	$CutSceneManager.start()
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

