extends Marker2D
class_name ItemDisplay

var item_resource: Resource
@export var position_marker: Marker2D

func _ready():
	$ItemSprite.visible = true


func _on_actionable_action(source: Node2D):
	if source is Player or source is Visitor:
		var resource = source.item_holding_component.resource
		var previous_resource = item_resource
		set_resource(resource)
		source.item_change_interaction(previous_resource)

func _on_ui_item_resource_changed(resource):
	set_resource(resource)

func set_resource(resource):
	item_resource = resource
	if resource:
		$ItemSprite.visible = true
		$ItemSprite.texture = item_resource.ingame_texture
	else:
		$ItemSprite.visible = false
		$ItemSprite.texture = null
