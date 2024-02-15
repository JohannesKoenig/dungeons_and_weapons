class_name CutSceneManager extends Node
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var player_intro_strategy: Dictionary
var major_intro_strategy: Dictionary

@export var player_resource: AdventurerResource
@export var major_resource: AdventurerResource

var player: Visitor
var major: Visitor

var visitor_resource = preload("res://visitor/visitor.tscn")

var ai_path_markers: AiPathMarkers
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	ai_path_markers = get_node("/root/AiPathMarkers")
	
	var resource = FileAccess.open("res://Resources/ai/player_intro_strategy.json", FileAccess.READ)
	player_intro_strategy = JSON.parse_string(resource.get_as_text())
	
	resource = FileAccess.open("res://Resources/ai/major_intro_strategy.json", FileAccess.READ)
	major_intro_strategy = JSON.parse_string(resource.get_as_text())

func start():
	var player = visitor_resource.instantiate()
	player.set_adventurer_resource(player_resource)
	player.set_strategy(player_intro_strategy)
	add_child(player)
	player.global_position = ai_path_markers.position_register["player_intro_spawn_position"].global_position

	var major = visitor_resource.instantiate()
	major.set_adventurer_resource(major_resource)
	major.set_strategy(major_intro_strategy)
	add_child(major)
	major.global_position = ai_path_markers.position_register["major_intro_spawn_position"].global_position
	

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

