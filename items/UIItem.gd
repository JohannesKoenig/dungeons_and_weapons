extends Control
class_name UIItem

@export var weapon_resource: WeaponResource
signal resource_changed(resource: Resource)

func _ready():
	set_resource(weapon_resource)
	
func set_resource(resource: WeaponResource):
	weapon_resource = resource
	$Content/UIItemIcon.set_resource(weapon_resource)

func _on_UIItemIcon_resource_changed(resource: Resource):
	weapon_resource = resource
	resource_changed.emit(resource)
	if weapon_resource:
		$Content/CostContainer/Cost.text = str(weapon_resource.price)
		$Content/Name.text = weapon_resource.name
	else:
		$Content/CostContainer/Cost.text = "-"
		$Content/Name.text = "-"
