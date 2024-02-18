class_name DungeonDoor
extends Node2D


func _on_area_2d_body_entered(body):
	#get_node("/root/GameSaver").save_game_from_resources()
	if body is Player:
		get_tree().change_scene_to_file("res://Scenes/tavern_game_scene.tscn")
