extends Control

@export var inventory_component: InventoryComponent
var packed_ui_scene: PackedScene
var ui_items: Array

func _ready():
	set_inventory_component(inventory_component)
	packed_ui_scene = load("res://items/UIItemIcon.tscn")

func set_inventory_component(inventory_component: InventoryComponent):
	self.inventory_component = inventory_component

	_delete_ui_items()
	if self.inventory_component:
		_create_ui_items(inventory_component.inventory_size)
		

func _delete_ui_items():
	for item in ui_items:
		$GridContainer.remove_child(item)
		item.queue_free()
	ui_items = []

func _create_ui_items(amount: int):
	for i in range(amount):
		var item = packed_ui_scene.instantiate()
		$GridContainer.add_child(item)
		ui_items.append(item)
	var x_size_item = ui_items[0].size.x
	var x_size_container = min(4,amount) * x_size_item + (4)
	$GridContainer.size = Vector2(x_size_container,x_size_container)
	# $GridContainer.position = Vector2(-x_size_container/2, -40)
