extends Node
class_name PlayerInputHandler

var player_quick_access_resource: QuickAccessResource = preload("res://player/player_quick_access.tres")
signal toggle_inventory
signal toggle_menu

func _process(delta):
	_handle_input()

func _handle_input():
	if Input.is_action_just_pressed("Escape"):
		toggle_menu.emit()
	if Input.is_action_just_pressed("scroll_inventory_left"):
		player_quick_access_resource.select_next_index()
	if Input.is_action_just_pressed("scroll_inventory_right"):
		player_quick_access_resource.select_previous_index()
	if Input.is_action_just_pressed("1"):
		player_quick_access_resource.select_index(0)
	if Input.is_action_just_pressed("2"):
		player_quick_access_resource.select_index(1)
	if Input.is_action_just_pressed("3"):
		player_quick_access_resource.select_index(2)
	if Input.is_action_just_pressed("4"):
		player_quick_access_resource.select_index(3)
	if Input.is_action_just_pressed("5"):
		player_quick_access_resource.select_index(4)
	if Input.is_action_just_pressed("6"):
		player_quick_access_resource.select_index(5)
	if Input.is_action_just_pressed("7"):
		player_quick_access_resource.select_index(6)
	if Input.is_action_just_pressed("8"):
		player_quick_access_resource.select_index(7)
	if Input.is_action_just_pressed("9"):
		player_quick_access_resource.select_index(8)
	if Input.is_action_just_pressed("0"):
		player_quick_access_resource.select_index(9)
