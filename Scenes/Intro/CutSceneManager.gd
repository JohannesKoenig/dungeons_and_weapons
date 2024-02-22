class_name CutSceneManager extends Node
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var player_intro_strategy: Dictionary
var major_intro_strategy: Dictionary
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")

var _real_player_resource: PlayerResource = preload("res://player/player_resource.tres")
@export var player_resource: AdventurerResource
@export var major_resource: AdventurerResource
@export var camera: Camera2D
@export var camera_offset: Vector2
@export var pan_duration: float

var _factory: AdventurerFactory = preload("res://adventurer/adventurer_factory.tres")
var player: Visitor
var major: Visitor

var visitor_resource = preload("res://visitor/visitor.tscn")

var ai_path_markers: AiPathMarkers
var timer: Timer
var tween: Tween

var start_dialog: bool = false:
	set(value):
		if value != start_dialog:
			start_dialog = value
			start_dialog_changed.emit()
signal start_dialog_changed
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	timer = Timer.new()
	add_child(timer)
	ai_path_markers = get_node("/root/AiPathMarkers")
	
	var resource = FileAccess.open("res://Resources/ai/player_intro_strategy.json", FileAccess.READ)
	player_intro_strategy = JSON.parse_string(resource.get_as_text())
	
	resource = FileAccess.open("res://Resources/ai/major_intro_strategy.json", FileAccess.READ)
	major_intro_strategy = JSON.parse_string(resource.get_as_text())
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func start():
	player = visitor_resource.instantiate()
	var fake_player_resource = _factory.get_random()
	fake_player_resource.head = _real_player_resource.head
	fake_player_resource.body = _real_player_resource.body
	fake_player_resource.legs = _real_player_resource.legs
	
	player.set_adventurer_resource(fake_player_resource)
	player.set_strategy(player_intro_strategy)
	add_child(player)
	player.global_position = ai_path_markers.position_register["player_intro_spawn_position"].global_position
	player.ai_movement_mapper.start_await_state.connect(_start_dialog)

	major = visitor_resource.instantiate()
	major.set_adventurer_resource(major_resource)
	major.set_strategy(major_intro_strategy)
	add_child(major)
	major.global_position = ai_path_markers.position_register["major_intro_spawn_position"].global_position
	major.ai_movement_mapper.start_await_state.connect(_start_dialog)
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(camera, "zoom:x", 1.5, pan_duration)
	tween.tween_property(camera, "zoom:y", 1.5, pan_duration)
	tween.tween_property(camera, "position:x", camera.position.x + camera_offset.x, pan_duration)
	tween.tween_property(camera, "position:y", camera.position.y + camera_offset.y, pan_duration)
	

func _start_dialog(source: AIMovementMapper):
	start_dialog = true

func conversation_over():
	player.ai_movement_mapper.conversation_over = true
	major.ai_movement_mapper.conversation_over = true
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(camera, "zoom:x", 1.0, pan_duration)
	tween.tween_property(camera, "zoom:y", 1.0, pan_duration)
	tween.tween_property(camera, "position:x", 128, pan_duration)
	tween.tween_property(camera, "position:y", 128, pan_duration)
	timer.start(pan_duration)
	await timer.timeout
	_message_dispatcher.skip_intro = true
	get_tree().change_scene_to_file("res://Scenes/tavern_game_scene.tscn")
