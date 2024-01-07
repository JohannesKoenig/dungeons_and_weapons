extends Control

@onready var clock_label = $MarginContainer/HBoxContainer/Clock
@onready var coins_label = $MarginContainer/HBoxContainer/Coins

func update_coins(coins: int) -> void:
	coins_label.text = str(coins)

func update_time(is_day: bool, hours: int, minutes: int) -> void:
	clock_label.text = "%02d:%02d" % [hours, minutes]
