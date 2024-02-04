class_name Inventory
extends Node

@export var inventory_resource: InventoryResource
signal inventory_changed(items: Array)
func _on_inventory_resource_changed(items: Array):
	inventory_changed.emit(items)

func _ready():
	if inventory_resource:
		set_inventory_resource(self.inventory_resource)
	
func set_inventory_resource(inventory_resource: InventoryResource):
	self.inventory_resource = inventory_resource
	self.inventory_resource.items_changed.connect(_on_inventory_resource_changed)
