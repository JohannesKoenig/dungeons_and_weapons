class_name Inventory
extends Node

@export var inventory_resource: InventoryResource
signal inventory_changed(items: Array)
func _on_inventory_resource_changed(items: Array):
	inventory_changed.emit(items)

func _ready():
	inventory_resource.items_changed.connect(_on_inventory_resource_changed)
