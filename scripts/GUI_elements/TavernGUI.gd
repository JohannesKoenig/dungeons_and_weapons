extends Control

@onready var clock_label = $MarginContainer/HBoxContainer/Clock
@onready var coins_label = $MarginContainer/HBoxContainer/Coins
@export var player_resource: PlayerResource


func _ready():
	set_player_resource(player_resource)

func _process(delta):
	_update_coin_label(player_resource.coins)

func update_coins(coins: int) -> void:
	coins_label.text = str(coins)

func update_time(is_day: bool, hours: int, minutes: int) -> void:
	if clock_label:
		clock_label.text = "%02d:%02d" % [hours, minutes]

func toggle_inventory():
	$InventoryToggle.toggle()

func set_player_resource(player_resource: PlayerResource):
	_update_coin_label(player_resource.coins)

func _update_coin_label(value: int):
	$MarginContainer/HBoxContainer/Coins.text = str(value)

func show_day_time_pop_up():
	$DayTimePopUp.show_content()

func show_night_time_pop_up():
	$NightTimePopUp.show_content()
