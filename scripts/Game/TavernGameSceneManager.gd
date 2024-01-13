extends Node2D

var ai_path_markers: AiPathMarkers


func _ready():
	ai_path_markers = get_node("/root/AiPathMarkers")
	if ai_path_markers:
		ai_path_markers.register_position("spawn_position", $Entities/Marker/SpawnPoint)
		ai_path_markers.register_position("door_position", $Entities/Marker/DoorPoint)
		ai_path_markers.register_position("hallway_position", $Entities/Marker/HallwayPoint)
		ai_path_markers.register_position("dungeon_position", $Entities/Marker/DungeonPoint)
		ai_path_markers.register_position("despawn_position", $Entities/Marker/DespawnPoint)
		ai_path_markers.register_position("store_position", $Entities/Marker/StorePoint)
		ai_path_markers.register_position("counter_position", $Entities/Marker/CounterPoint)
		ai_path_markers.register_position("shelve_1_1_position", $Entities/Marker/Shelve1Point1)
		ai_path_markers.register_position("shelve_1_2_position", $Entities/Marker/Shelve1Point2)
		ai_path_markers.register_position("shelve_1_3_position", $Entities/Marker/Shelve1Point3)
		ai_path_markers.register_position("shelve_2_1_position", $Entities/Marker/Shelve2Point1)
		ai_path_markers.register_position("shelve_2_2_position", $Entities/Marker/Shelve2Point2)
		ai_path_markers.register_position("shelve_2_3_position", $Entities/Marker/Shelve2Point3)

