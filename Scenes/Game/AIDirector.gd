extends Node
class_name AIDirector

@export var tavern_ai: TavernAI
@export var npc_spawner: NPCSpawner
@export var movement_stats: MovementStats
var strategies: Dictionary
var items: Array
var adventurer_resources: Array

@export var weapon_resource: WeaponResource
var ai_resource = preload("res://Scenes/Game/Units/AIMovementMapper.tscn")

func update_instructions(items: Array, adventurer_resources: Array):
	self.items = items
	self.adventurer_resources = adventurer_resources
	self.strategies = _get_strategies(_remove_nulls(self.items), self.adventurer_resources)
	npc_spawner.set_adventurer_strategy_map(strategies)
	npc_spawner.start_spawning()

func _get_strategies(item_stock: Array, adventurers: Array) -> Dictionary:
	return tavern_ai.calculate_strategies(item_stock, adventurers)

func _remove_nulls(array: Array) -> Array:
	var new_array = []
	for elem in array:
		if elem["item"] != null:
			new_array.append(elem)
	return new_array
