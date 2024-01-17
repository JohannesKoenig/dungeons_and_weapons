extends Node2D
class_name ItemHoldingComponent

@export var resource: WeaponResource

func _ready():
	set_resource(resource)

func set_resource(resource: WeaponResource):
	self.resource = resource
	if self.resource:
		$ItemSprite.texture = resource.ingame_texture
	else:
		$ItemSprite.texture = null

func remove_resource() -> WeaponResource:
	var old_resource = self.resource
	self.resource = null
	$ItemSprite.texture = null
	return old_resource

func _on_qick_access_component_selected_changed(resource):
	set_resource(resource)
