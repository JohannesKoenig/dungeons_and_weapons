extends Control

@export var quick_access_component: QuickAccessComponent

var ui_items: Array

var packed_ui_scene: PackedScene

func _ready():
	set_quick_access_component(quick_access_component)
	packed_ui_scene = load("res://items/UIItemIcon.tscn")

func set_quick_access_component(quick_access_component):
	self.quick_access_component = quick_access_component
	_delete_ui_items()
	if self.quick_access_component:
		_create_ui_items(quick_access_component.size)
		

func _delete_ui_items():
	for item in ui_items:
		$HBoxContainer.remove_child(item)
		item.queue_free()
	ui_items = []

func _create_ui_items(amount: int):
	for i in range(amount):
		var item = packed_ui_scene.instantiate()
		$HBoxContainer.add_child(item)
		ui_items.append(item)
	var x_size_item = ui_items[0].size.x
	var x_size_container = amount * x_size_item + (amount)
	$Panel.size = Vector2(x_size_container + 8,26)
	$Panel.position = Vector2(-(x_size_container + 8)/2, -40)
	$HBoxContainer.size = Vector2(x_size_container,26)
	$HBoxContainer.position = Vector2(-x_size_container/2, -40)
