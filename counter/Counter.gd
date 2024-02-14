extends Node2D

@export var player_resource: PlayerResource
@export var tavern_resource: TavernResource
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")

func interact_buy_item(source: Node2D):
	if source is Player:
		return
	if source is Visitor:
		var adventurer_resource: AdventurerResource = source.adventurer_resource
		var inventory: InventoryResource = adventurer_resource.inventory
		var quick_access: QuickAccessResource = adventurer_resource.quick_access
		var item: Item = inventory.items[quick_access.selected_index]
		adventurer_resource.coins -= item.value
		sell(item)


func sell(item: Item):
	player_resource.coins += item.value


func interact_open_tavern(source):
	if source is Node and not("player" in source.get_groups()):
		return
	toggle_tavern_open()


func toggle_tavern_open():
	_message_dispatcher.requested_shop_open.emit()
	#tavern_resource.toggle_tavern()
