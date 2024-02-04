class_name TavernResource
extends Resource

@export var inventory: InventoryResource
@export var fee: int
@export var open: bool

signal tavern_open_changed(value: bool)
var _dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")

func toggle_tavern():
	open_tavern(!open)

func open_tavern(value: bool):
	if not value and not _dnr.is_day:
		open = value
		tavern_open_changed.emit(value)
	if value and _dnr.is_day:
		open = value
		tavern_open_changed.emit(value)
