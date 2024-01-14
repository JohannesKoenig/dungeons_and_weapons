extends Node2D
class_name ItemHoldingComponent

var resource: WeaponResource

func set_resource(resource: WeaponResource):
	self.resource = resource
	$ItemSprite.texture = resource.ingame_texture

func remove_resource() -> WeaponResource:
	var old_resource = self.resource
	self.resource = null
	$ItemSprite.texture = null
	return old_resource
