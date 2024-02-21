class_name RentPayingComponent extends Node
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var rent: int = 100
var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")
var player_resource: PlayerResource = preload("res://player/player_resource.tres")
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	dnr.day_ended.connect(_pay_rent)

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _pay_rent():
	player_resource.coins -= rent
	if player_resource.coins < 0:
		_message_dispatcher.requested_game_over.emit()
