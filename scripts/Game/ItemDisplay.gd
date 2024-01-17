extends Marker2D
class_name ItemDisplay

var item_resource: Resource

func _ready():
	$ItemSprite.visible = true


func _on_actionable_action(message):
	#$ToggleComponent.activate()
	if "selected_resource" in message:
		var resource = message["selected_resource"]
		var previous_resource = item_resource
		set_resource(resource)
		var callback = message["on_success"]
		callback.call(previous_resource)

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
