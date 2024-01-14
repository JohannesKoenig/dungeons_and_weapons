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
		_load_ui_items()
		inventory_component.inventory_changed.connect(_refresh_items)

func _refresh_items(items: Array):
	_load_ui_items()

func _load_ui_items():
	for i in range(inventory_component.inventory_size):
		var resource = inventory_component.inventory[i]
		ui_items[i].set_resource(resource)

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
		item.resource_changed.connect(_on_resource_changed_for_index(i))
	var x_size_item = ui_items[0].size.x
	var x_size_container = min(4,amount) * x_size_item + (4)
	$GridContainer.size = Vector2(x_size_container,x_size_container)

func _on_resource_changed_for_index(index: int) -> Callable:
	return func _on_resource_changed(resource: Resource):
		inventory_component.add_item_at_index(resource, index)
