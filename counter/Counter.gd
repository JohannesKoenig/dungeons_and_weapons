extends Node2D

@export var player: Player
@export var tavern_manager: TavernManager

func interact_buy_item(message: Dictionary):
	var source = message["source"]
	if source == player:
		return
	var item = message["item"]
	sell(item)
	var callback_on_success = message["on_success"]
	callback_on_success.call()


func sell(item: WeaponResource):
	player.coin_bank_component.add(item.price)


func interact_open_tavern(source):
	if source is Node and not("player" in source.get_groups()):
		return
	print("tavern open")
	toggle_tavern_open()


func toggle_tavern_open():
	tavern_manager.toggle_tavern()
