extends Node2D

var ai_path_markers: AiPathMarkers


func _ready():
	ai_path_markers = get_node("/root/AiPathMarkers")
	if ai_path_markers:
		ai_path_markers.register_position("spawn_position", $SpawnPoint)
		ai_path_markers.register_position("door_position", $DoorPoint)
		ai_path_markers.register_position("hallway_position", $HallwayPoint)
		ai_path_markers.register_position("dungeon_position", $DungeonPoint)
		ai_path_markers.register_position("despawn_position", $DespawnPoint)
		ai_path_markers.register_position("store_position", $StorePoint)
		ai_path_markers.register_position("counter_position", $CounterPoint)
		ai_path_markers.register_position("shelve_1_1_position", $Shelve1Point1)
		ai_path_markers.register_position("shelve_1_2_position", $Shelve1Point2)
		ai_path_markers.register_position("shelve_1_3_position", $Shelve1Point3)
		ai_path_markers.register_position("shelve_2_1_position", $Shelve2Point1)
		ai_path_markers.register_position("shelve_2_2_position", $Shelve2Point2)
		ai_path_markers.register_position("shelve_2_3_position", $Shelve2Point3)

