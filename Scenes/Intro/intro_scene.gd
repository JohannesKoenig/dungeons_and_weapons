class_name IntroScene extends Node2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var ai_path_markers: AiPathMarkers
@onready var cut_scene_manager: CutSceneManager = $CutSceneManager
var dialog_resource: Dictionary
@onready var speech_bubble: SpeechBubble = $CanvasLayer/SpeechBubble
var timer: Timer
var player_resource: PlayerResource = preload("res://player/player_resource.tres")
signal action_pressed
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	ai_path_markers = get_node("/root/AiPathMarkers")
	if ai_path_markers:
		ai_path_markers.register_position("door_position", $Entities/Marker/DoorPoint)
		ai_path_markers.register_position("hallway_position", $Entities/Marker/HallwayPoint)
		ai_path_markers.register_position("player_intro_spawn_position", $Entities/Marker/PlayerIntroSpawnPoint)
		ai_path_markers.register_position("player_conversation_position",  $Entities/Marker/PlayerConversationPoint)
		ai_path_markers.register_position("major_intro_spawn_position", $Entities/Marker/MajorIntroSpawnPoint)
		ai_path_markers.register_position("major_conversation_position",  $Entities/Marker/MajorConversationPoint)
	
	var resource = FileAccess.open("res://Scenes/Intro/intro_dialog.json", FileAccess.READ)
	dialog_resource = JSON.parse_string(resource.get_as_text())
	
	cut_scene_manager.start()
	cut_scene_manager.start_dialog_changed.connect(_start_dialog)

func _process(delta):
	if Input.is_action_just_pressed("action"):
		action_pressed.emit()
		
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _start_dialog():
	var dialog_pieces = dialog_resource["dialog"]
	for dialog_piece in dialog_pieces:
		speech_bubble.set_line(_replace_strings(dialog_piece))
		await action_pressed
	speech_bubble.set_line({})
	cut_scene_manager.conversation_over()

func _replace_strings(dialog_piece: Dictionary) -> Dictionary:
	dialog_piece["line"]= dialog_piece["line"].replace("<name>", player_resource.player_name)
	dialog_piece["speaker"] = dialog_piece["speaker"].replace("<name>", player_resource.player_name)
	return dialog_piece
