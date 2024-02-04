extends Node2D
class_name ItemHoldingComponent

@export var inventory_resource: InventoryResource 
@export var quick_access: QuickAccessResource

@onready var _item_sprite: Sprite2D = $ItemSprite

func _ready():
	if quick_access:
		quick_access.index_updated.connect(index_updated)
		index_updated(quick_access.selected_index)
	if inventory_resource:
		inventory_resource.items_changed.connect(items_updated)
		items_updated(inventory_resource.items)

func set_inventory_resource(inventory_resource: InventoryResource):
	self.inventory_resource = inventory_resource
	if inventory_resource:
		inventory_resource.items_changed.connect(items_updated)
		items_updated(inventory_resource.items)

func set_quick_access(quick_access: QuickAccessResource):
	self.quick_access = quick_access
	if quick_access:
		quick_access.index_updated.connect(index_updated)
		index_updated(quick_access.selected_index)

func items_updated(items: Array):
	if quick_access:
		update(items, quick_access.selected_index)

func index_updated(index: int):
	if inventory_resource:
		update(inventory_resource.items, index)

func update(items: Array, index: int):
	var item: Item = items[index]
	if item:
		_item_sprite.visible = true
		_item_sprite.texture = item.ingame_texture
	else:
		_item_sprite.visible = false
		_item_sprite.texture = null
