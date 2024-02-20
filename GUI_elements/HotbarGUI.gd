extends Control

@export var quick_access_resource: QuickAccessResource
var input_type_resource: InputTypeResource = preload("res://Resources/input_type_resource.tres")

var ui_items: Array

var packed_ui_scene: PackedScene = preload("res://items/UIItemIcon.tscn")

var hint_map = {
	0: preload("res://icons/1.png"),
	1: preload("res://icons/2.png"),
	2: preload("res://icons/3.png"),
	3: preload("res://icons/4.png"),
	4: preload("res://icons/5.png"),
	5: preload("res://icons/6.png"),
	6: preload("res://icons/7.png"),
	7: preload("res://icons/8.png"),
	8: preload("res://icons/9.png"),
	9: preload("res://icons/0.png"),
}

func _ready():
	if quick_access_resource:
		set_quick_access_resource(quick_access_resource)

func set_quick_access_resource(quick_access_resource):
	self.quick_access_resource = quick_access_resource
	_delete_ui_items()
	if self.quick_access_resource:
		_create_ui_items(quick_access_resource.size)
		_load_ui_items()
		quick_access_resource.inventory_resource.items_changed.connect(_refresh_items)
		quick_access_resource.index_updated.connect(_selected_index_changed)

	_update_input_hints()
	input_type_resource.type_changed.connect(_update_input_hints)

func _refresh_items(items: Array):
	_load_ui_items()

func _delete_ui_items():
	for item in ui_items:
		$HBoxContainer.remove_child(item)
		item.queue_free()
	ui_items = []

func _create_ui_items(amount: int):
	for i in range(amount):
		var item: UIItemIcon = packed_ui_scene.instantiate()
		item.set_hint_texture(hint_map[i])
		$HBoxContainer.add_child(item)
		ui_items.append(item)
		item.resource_changed.connect(_on_resource_changed_for_index(i))
	var x_size_item = ui_items[0].size.x
	var x_size_container = amount * x_size_item + (amount)
	$Panel.size = Vector2(x_size_container + 8,26)
	$Panel.position = Vector2(-(x_size_container + 8)/2, -40)
	$HBoxContainer.size = Vector2(x_size_container,26)
	$HBoxContainer.position = Vector2(-x_size_container/2, -40)

func _load_ui_items():
	for i in range(quick_access_resource.size):
		var resource = quick_access_resource.inventory_resource.items[i]
		ui_items[i].set_resource(resource)
		
func _on_resource_changed_for_index(index: int) -> Callable:
	return func _on_resource_changed(resource: Resource):
		quick_access_resource.add_item(resource, index)

func _selected_index_changed(index: int):
	for item in ui_items:
		item.set_highlighted(false)
	ui_items[index].set_highlighted(true)

func _update_input_hints():
	if input_type_resource.is_controller:
		$Panel/TextureRect.visible = true
		$Panel/TextureRect2.visible = true
	else:
		$Panel/TextureRect.visible = false
		$Panel/TextureRect2.visible = false
