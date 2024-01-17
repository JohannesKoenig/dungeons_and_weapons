extends Node2D

@export var player: Adventurer

func interact(message: Dictionary):
	var source = message["source"]
	if source == player:
		return
	var item = message["item"]
	sell(item)
	var callback_on_success = message["on_success"]
	callback_on_success.call()

func sell(item: WeaponResource):
	player.coin_bank_component.add(item.price)
