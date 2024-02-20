extends Marker2D
class_name ItemDisplay

var item_resource: Resource
@export var position_marker: Marker2D
@export var tavern_inventory_resource: InventoryResource
@export var index: int

func _ready():
	$ItemSprite.visible = true
	tavern_inventory_resource.items_changed.connect(set_resource)
	set_resource(tavern_inventory_resource.items)


func _on_actionable_action(source: Node2D):
	if source is Player:
		var selected_item = source.player_resource.inventory.items[source.player_resource.quick_access.selected_index]
		var previous_item = tavern_inventory_resource.add_at_position(selected_item, index)
		source.item_change_interaction(previous_item)
		# source.player_resource.inventory.add_at_position(previous_item, source.player_resource.quick_access.selected_index)
	elif source is Visitor:
		var previous_item = tavern_inventory_resource.remove_at_index(index)
		if previous_item:
			source.item_change_interaction(previous_item)
		

func _on_ui_item_resource_changed(resource):
	set_resource(resource)


func set_resource(items: Array):
	var item: Item = items[index]
	if item:
		$ItemSprite.visible = true
		$ItemSprite.texture = item.ingame_texture
		$Tooltip.item = item
		$Shadow.visible = true
	else:
		$ItemSprite.visible = false
		$ItemSprite.texture = null
		$Tooltip.item = null
		$Shadow.visible = false


func _on_actionable_is_closest_to_player_changed(value):
	if value:
		$Actionable/InputHint.show_hint()
		$Tooltip.show_tooltip()
	else:
		$Actionable/InputHint.hide_hint()
		$Tooltip.hide_tooltip()
