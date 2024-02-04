extends Control

@export var inventory_resource: InventoryResource
@export var quick_access_component: QuickAccessComponent
var packed_ui_scene: PackedScene = preload("res://items/UIItemIcon.tscn")
var ui_items: Array

func _ready():
	if inventory_resource:
		set_inventory_resource(inventory_resource)
	set_quick_access_component(quick_access_component)

func set_inventory_resource(inventory_resource: InventoryResource):
	self.inventory_resource = inventory_resource
	_delete_ui_items()
	if self.inventory_resource:
		_create_ui_items(inventory_resource.size)
		_load_ui_items()
		inventory_resource.items_changed.connect(_refresh_items)

func set_quick_access_component(quick_access_component: QuickAccessComponent):
	self.quick_access_component = quick_access_component

func _refresh_items(items: Array):
	_load_ui_items()

func _load_ui_items():
	for i in range(inventory_resource.size):
		var resource = inventory_resource.items[i]
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
		item.right_clicked.connect(_quick_move_for_index(i))
	var x_size_item = ui_items[0].size.x
	var x_size_container = min(4,amount) * x_size_item + (4)
	$GridContainer.size = Vector2(x_size_container,x_size_container)


func _on_resource_changed_for_index(index: int) -> Callable:
	return func _on_resource_changed(resource: Resource):
		inventory_resource.add_at_position(resource, index)


func _quick_move_for_index(index: int) -> Callable:
	return func _quick_move_item(resource: Resource):
		var success = quick_access_component.add_item_to_first_free_slot(resource)
		if success:
			inventory_resource.remove_item(resource)
