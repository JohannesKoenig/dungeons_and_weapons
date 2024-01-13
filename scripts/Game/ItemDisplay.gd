extends Marker2D
class_name ItemDisplay

var item_resource: Resource
@onready var ui_item = $PopUpGuiComponent/UIItem

func _ready():
	$ItemSprite.visible = true


func _on_actionable_action(message):
	$ToggleComponent.activate()
	var new_resource = message["item_resource"]
	if new_resource != item_resource:
		item_resource = new_resource
		$PopUpGuiComponent.content.set_resource(item_resource)
		if item_resource:
			$ItemSprite.visible = true
			$ItemSprite.texture = item_resource.ingame_texture
