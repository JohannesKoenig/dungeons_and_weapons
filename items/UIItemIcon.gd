extends Control

var resource: Resource
@export var default_texture: Texture

func _can_drop_data(at_position, data):
	return true

func _get_drag_data(at_position):
	var data = {
		"origin_node": self,
		"resource": resource,
		"test": "hello"
	}
	return data

func _drop_data(at_position, data):
	print("drop data")
	if not resource:
		var this_resource = resource
		set_resource(data["resource"])
		data["origin_node"].set_resource(this_resource)

func set_resource(resource: Resource):
	self.resource = resource
	if resource:
		$Texture.texture = resource.icon_texture
	else:
		$Texture.texture = default_texture
	
