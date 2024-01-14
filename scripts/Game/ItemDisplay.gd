extends Marker2D
class_name ItemDisplay

var item_resource: Resource

func _ready():
	$ItemSprite.visible = true


func _on_actionable_action(message):
	$ToggleComponent.activate()


func _on_ui_item_resource_changed(resource):
	if resource:
		item_resource = resource
		$ItemSprite.visible = true
		$ItemSprite.texture = item_resource.ingame_texture
	else:
		$ItemSprite.visible = false
		$ItemSprite.texture = null
