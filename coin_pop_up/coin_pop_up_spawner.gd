class_name CoinPopUpSpawner extends Node2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var coin_pop_up = preload("res://coin_pop_up/coin_pop_up.tscn")
@export var player_resource: PlayerResource = preload("res://player/player_resource.tres")
@onready var audio_player: AudioStreamPlayer2D = $SoundEffectPlayer
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	player_resource.coins_changed_delta.connect(_on_coins_changed)

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_coins_changed(value: int, delta: int):
	if delta == 0:
		return
	var instance = coin_pop_up.instantiate()
	instance.set_value(delta)
	add_child(instance)
	audio_player.play()
