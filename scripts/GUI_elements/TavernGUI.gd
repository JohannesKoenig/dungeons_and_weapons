extends Control

@export var player_resource: PlayerResource
@export var dnr: DayNightResource
@export var tavern_resource: TavernResource
@onready var clock_label = $MarginContainer/HBoxContainer/Clock
@onready var coins_label = $MarginContainer/HBoxContainer/Coins


func _ready():
	dnr.time_changed.connect(update_time)
	player_resource.coins_changed.connect(update_coins)
	update_coins(player_resource.coins)
	set_player_resource(player_resource)
	show_tavern_open(tavern_resource.open)
	tavern_resource.tavern_open_changed.connect(show_tavern_open)

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

func show_tavern_open(value: bool):
	if value:
		$TavernOpenTimedPopUp.show_content()
		$TavernOpenTimedPopUp/TavernOpen.start_animation()
