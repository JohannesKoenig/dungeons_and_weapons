class_name DungeonTransitionScene extends Control
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var timer: Timer
var dungeon_generator_resource: DungeonGeneratorResource = preload("res://dungeon_generator/dungeon_generator_resource.tres")
var index = 0
@onready var dropped_item_display: DroppedItemDisplay = $DroppedItemDisplay
@onready var no_loot_label: Label = $NoLoot
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	$InputHint.show_hint()
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(add_item)
	timer.start(0.5)
	no_loot_label.visible = false

func _process(delta):
	if Input.is_action_just_pressed("action"):
		get_tree().change_scene_to_file("res://Scenes/dungeon_game_scene.tscn")
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

func add_item():
	if len(dungeon_generator_resource.dropped_items) == 0:
		no_loot_label.visible = true
		$Label.visible = false
		return
	var item = dungeon_generator_resource.dropped_items[index]
	dropped_item_display.spawn_item(item)
	index += 1
	if index < len(dungeon_generator_resource.dropped_items):
		timer.start()
