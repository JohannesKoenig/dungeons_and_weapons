extends Control

@onready var clock_label = $MarginContainer/HBoxContainer/Clock
@onready var coins_label = $MarginContainer/HBoxContainer/Coins
@export var player: Adventurer

func _ready():
	set_player(player)

func update_coins(coins: int) -> void:
	coins_label.text = str(coins)

func update_time(is_day: bool, hours: int, minutes: int) -> void:
	if clock_label:
		clock_label.text = "%02d:%02d" % [hours, minutes]

func toggle_inventory():
	$InventoryToggle.toggle()

func set_quick_access_component(quick_access_component: QuickAccessComponent):
	$HotbarGui.set_quick_access_component(quick_access_component)

func set_player(adventurer: Adventurer):
	player.coin_bank_component.value_changed.connect(_update_coin_label)
	_update_coin_label(player.coin_bank_component.value)

func _update_coin_label(value: int):
	$MarginContainer/HBoxContainer/Coins.text = str(value)
