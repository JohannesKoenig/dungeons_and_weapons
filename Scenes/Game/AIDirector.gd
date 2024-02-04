extends Node
class_name AIDirector

@export var tavern_resource: TavernResource
@export var customers_resource: CustomersResource
@export var tavern_ai: TavernAI
@export var npc_spawner: NPCSpawner
var strategies: Dictionary
var items: Array
var adventurer_resources: Array

func update_instructions():
	self.items = tavern_resource.inventory.items
	self.adventurer_resources = customers_resource.today
	self.strategies = _get_strategies(_remove_nulls(self.items), self.adventurer_resources)
	npc_spawner.set_adventurer_strategy_map(strategies)
	npc_spawner.start_spawning()

func _get_strategies(item_stock: Array, adventurers: Array) -> Dictionary:
	return tavern_ai.calculate_strategies(item_stock, adventurers)

func _remove_nulls(array: Array) -> Array:
	var new_array = []
	for elem in array:
		if elem != null:
			new_array.append(elem)
	return new_array
