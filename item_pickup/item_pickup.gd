class_name ItemPickup extends Node2D

@export var inventory: InventoryResource 
@export var index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	if inventory:
		set_inventory(inventory)

func set_inventory(inventory: InventoryResource):
	self.inventory = inventory
	if inventory:
		inventory.items_changed.connect(_update_items)

func _update_sprite(items: Array, index: int):
	var item = items[index]
	if item:
		$Sprite2D.texture = items[index].ingame_texture
		visible = true
	else:
		visible = false


func update_index(index: int):
	self.index = index
	if inventory:
		_update_sprite(inventory.items, index)
	
func _update_items(items: Array):
	_update_sprite(items, index)

func on_collect(source):
	if source is Player:
		if inventory:
			var pos = source.player_resource.inventory.add(inventory.items[index])
			if pos != -1:
				inventory.remove_at_index(index)
				queue_free()
