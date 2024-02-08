extends Node
class_name TavernAI

var buyer_strategy: Dictionary
var dungeon_strategy: Dictionary
@export var tavern_inventory: InventoryResource = preload("res://tavern/tavern_inventory_resource.tres")

func calculate_strategies(
	item_stock: Array,
	adventurers: Array
) -> Dictionary:
	var item_to_buyer_map := _map_items_to_buyer(adventurers)
	var adventurers_to_strategy_map = {}
	# all adventurers in map need buyer strategy
	for elem in item_to_buyer_map:
		var item = elem["item"]
		var buyer = elem["buyer"]
		adventurers_to_strategy_map[buyer] = _get_buyer_strategy(item)
	# all adventurers not in map need dungeon strategy
	for adventurer in adventurers:
		if adventurer not in adventurers_to_strategy_map:
			adventurers_to_strategy_map[adventurer] = _get_dungeon_strategy()
	return adventurers_to_strategy_map
	
func _get_buyer_strategy(item: Dictionary) -> Dictionary:
	var index = item["index"]
	var item_displays = get_tree().get_nodes_in_group("item_display")
	var position = null
	for item_display: ItemDisplay in item_displays:
		if item_display.index == index:
			position = item_display.position_marker
	var resource = FileAccess.open("res://Resources/ai/buyer_strategy.json", FileAccess.READ)
	var buyer_strategy = JSON.parse_string(resource.get_as_text())
	for state in buyer_strategy["states"]:
		if state["name"] == "shelve":
			state["parameters"]["target"] = position
	return buyer_strategy

func _get_dungeon_strategy() -> Dictionary:
	if dungeon_strategy.is_empty():
		var resource = FileAccess.open("res://Resources/ai/dungeon_strategy.json", FileAccess.READ)
		dungeon_strategy = JSON.parse_string(resource.get_as_text())
	return dungeon_strategy

func _map_items_to_buyer(
	adventurers: Array
) -> Array:
	var items = tavern_inventory.items
	var item_stock = []
	for i in range(len(items)):
		item_stock.append({
			"item": items[i],
			"index": i
		})
	var nr_of_adventurers = adventurers.size()
	var no_null = item_stock.filter(func(x): return x["item"])
	var nr_of_items = len(no_null)
	var item_stock_sorted_by_price = to_sorted_array(no_null, _compare_items_by_price)
	var adventurers_sorted_by_coins = to_sorted_array(adventurers, _compare_adventurers_by_coins)
	var map_item_to_buyer = []
	var j = 0
	for i in range(nr_of_items):
		if j >= nr_of_adventurers:
			break
		if item_stock_sorted_by_price[i]["item"].value <= adventurers_sorted_by_coins[j].coins:
			map_item_to_buyer.append({
				"item": item_stock_sorted_by_price[i],
				"buyer": adventurers_sorted_by_coins[j]
			})
			j += 1
			continue
	return map_item_to_buyer

func _compare_adventurers_by_coins(a: AdventurerResource, b: AdventurerResource) -> bool:
	return a.coins > b.coins

func _compare_items_by_price(a: Dictionary, b: Dictionary) -> bool:
	return a["item"].price > b["item"].price

func to_sorted_array(array: Array, comparator: Callable) -> Array:
	var duplicated = array.duplicate()
	duplicated.sort_custom(comparator)
	return duplicated
