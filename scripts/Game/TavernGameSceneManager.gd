extends Node2D

var ai_path_markers: AiPathMarkers
var interaction_middleware: InteractionMiddleware

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
	
	var drag_and_drop_layer = get_node("/root/DragAndDropLayer")
	drag_and_drop_layer.set_canvas_layer($CanvasLayer)
	$CanvasLayer/TavernScene.set_quick_access_component($Entities/Player/QickAccessComponent)
	$CanvasLayer/TavernScene/InventoryPopUp.content.set_inventory_component($Entities/Player/InventoryComponent)
	
	interaction_middleware = get_node("/root/InteractionMiddleware")
	$Entities/DayNightTimer.day_started.connect(
		interaction_middleware.day_starts
	)
	$Entities/DayNightTimer.night_started.connect(
		interaction_middleware.night_starts
	)
	
	var timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_start_npcs)
	timer.one_shot = true
	timer.start(2)
	

func _start_npcs():
	$Behaviours/AiDirector.update_instructions()
