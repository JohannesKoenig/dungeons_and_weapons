class_name DungeonDoor
extends Node2D

var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")

func _on_area_2d_body_entered(body):
	#get_node("/root/GameSaver").save_game_from_resources()
	if body is Player:
		_message_dispatcher.requested_tavern_after_dungeon.emit()
