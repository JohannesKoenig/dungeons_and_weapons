extends Node
class_name AIDirector

@export var tavern_ai: TavernAI
@export var npc_spawner: NPCSpawner
@export var movement_stats: MovementStats
var strategies: Dictionary
var items: Array
var adventurers: Array

@export var weapon_resource: WeaponResource
var ai_resource = preload("res://Scenes/Game/Units/AIMovementMapper.tscn")

func update_instructions():
	self.items = _get_items()
	self.adventurers = _get_adventurers()
	self.strategies = _get_strategies(self.items, self.adventurers)
	for adventurer in self.adventurers:
		adventurer.ai_mapper.set_strategy(self.strategies[adventurer])

func _get_items() -> Array:
	# TODO
	return [weapon_resource]

func _get_adventurers() -> Array:
	# TODO
	var adventurer = npc_spawner.spawn_adventurer()
	var ai_movement_mapper = ai_resource.instantiate()
	ai_movement_mapper.set_actor(adventurer)
	ai_movement_mapper.movement_stats = self.movement_stats
	adventurer.set_ai_mapper(ai_movement_mapper)
	return [adventurer]

func _get_strategies(item_stock: Array, adventurers: Array) -> Dictionary:
	return tavern_ai.calculate_strategies(item_stock, adventurers)
