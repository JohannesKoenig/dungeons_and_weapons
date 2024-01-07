extends Node2D
class_name TavernDoor

var is_open: bool = false

func open():
	is_open = true

func close():
	is_open = false
