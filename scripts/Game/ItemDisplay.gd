extends Marker2D
class_name ItemDisplay

var item_resource: Resource
@export var position_marker: Marker2D
@export var tavern_inventory_resource: InventoryResource
@export var index: int

func _ready():
	$ItemSprite.visible = true
	tavern_inventory_resource.items_changed.connect(set_resource)


func _on_actionable_action(source: Node2D):
	if source is Player:
		var selected_item = source.player_resource.inventory.items[source.player_resource.quick_access.selected_index]
		var previous_item = tavern_inventory_resource.add_at_position(selected_item, index)
		source.player_resource.inventory.add_at_position(previous_item, source.player_resource.quick_access.selected_index)
	elif source is Visitor:
		var selected_item = source.adventurer_resource.inventory.items[source.adventurer_resource.quick_access.selected_index]
		var previous_item = tavern_inventory_resource.add_at_position(selected_item, index)
		source.adventurer_resource.inventory.add_at_position(previous_item, source.adventurer_resource.quick_access.selected_index)
		

func _on_ui_item_resource_changed(resource):
	set_resource(resource)


func set_resource(items: Array):
	var item: Item = items[index]
	if item:
		$ItemSprite.visible = true
		$ItemSprite.texture = item.ingame_texture
	else:
		$ItemSprite.visible = false
		$ItemSprite.texture = null
