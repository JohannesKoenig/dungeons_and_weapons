class_name DeathState extends State
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")
var player_resource: PlayerResource = preload("res://player/player_resource.tres")
var dungeon_inventory: InventoryResource = preload("res://dungeon/dungeon_inventory.tres")
var timer: Timer
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _init():
	state_name = "death"

func on_enter():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.start(7)
	timer.timeout.connect(_on_timeout)
	var items = player_resource.inventory.items.duplicate()
	for item in items:
		dungeon_inventory.add(item)
	player_resource.inventory.clear()

func on_exit():
	get_tree().change_scene_to_file("res://Scenes/tavern_game_scene.tscn")
	pass

func _on_timeout():
	transitioned.emit("tavern_after_dungeon")
