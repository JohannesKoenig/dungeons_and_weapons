extends Control
class_name UIItem

@export var weapon_resource: WeaponResource

func _ready():
	if weapon_resource:
		set_resource(weapon_resource)
	
func set_resource(resource: WeaponResource):
	weapon_resource = resource
	$Content/Control/Texture.texture = weapon_resource.icon_texture
	$Content/CostContainer/Cost.text = str(weapon_resource.price)
	$Content/Name.text = weapon_resource.name
