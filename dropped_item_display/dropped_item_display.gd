class_name DroppedItemDisplay extends Node2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var spawn_point: Marker2D
var dropped_item: PackedScene = preload("res://dropped_item_display/dropped_item.tscn")
@export var item: Item = preload("res://Resources/weapons/saber/weapon.tres")
var item_factory: ItemFactory = preload("res://items/item/item_factory.tres")
var dungeon_generator_resource: DungeonGeneratorResource = preload("res://dungeon_generator/dungeon_generator_resource.tres")
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _process(delta):
	# dungeon_generator_resource.item_dropped.connect(spawn_item)
	pass
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------

func spawn_item(item: Item):
	var obj: DroppedItem = dropped_item.instantiate()
	obj.set_item(item)
	add_child(obj)
	obj.global_position = spawn_point.global_position + Vector2(randf_range(-5,5), 0)
