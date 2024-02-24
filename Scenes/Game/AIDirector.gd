extends Node
class_name AIDirector

@export var tavern_resource: TavernResource
@export var customers_resource: CustomersResource
@export var tavern_ai: TavernAI
@export var npc_spawner: NPCSpawner
var strategies: Dictionary
var items: Array
var adventurer_resources: Array
var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
@export var max_adventurers_per_hour: int = 4

func _ready():
	_message_dispatcher.game_state_changed.connect(trigger_ai_on_tavern_open)
	trigger_ai_on_tavern_open(_message_dispatcher.game_state)

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

func get_adventurers():
	var current_time = dnr.current_day_time
	var end_day_time = dnr.sun_down_hour * 60 + dnr.sun_down_minute
	var diff = end_day_time - current_time
	var diff_in_hours = float(diff) / 60
	var number_of_adventurers = randi_range(diff_in_hours * max_adventurers_per_hour / 2, diff_in_hours * max_adventurers_per_hour)
	var res = customers_resource.get_random_cutstomers(number_of_adventurers)
	customers_resource.available.append_array(res["new"])
	customers_resource.today = res["adventurers"]

func trigger_ai_on_tavern_open(state: State):
	if state is ShopState:
		get_adventurers()
		update_instructions()
