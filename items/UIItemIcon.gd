extends Control

@export var resource: Resource
signal resource_changed(resource: Resource)
signal right_clicked(resource: Resource)
@export var default_texture: Texture
@export var enable_drag_and_drop: bool = true
var mouse_insight = false

func _ready():
	set_resource(resource)
	set_highlighted(false)


func _process(delta):
	if Input.is_action_just_pressed("Right Mouse") and mouse_insight:
		right_clicked.emit(resource)


func _can_drop_data(at_position, data):
	return enable_drag_and_drop

func _get_drag_data(at_position):
	if not enable_drag_and_drop:
		return null
	if resource:
		var drag_preview_texture = load("res://items/UIItemDragPreview.tscn").instantiate()
		drag_preview_texture.texture = resource.icon_texture
		get_node("/root/DragAndDropLayer").get_canvas_layer().add_child(drag_preview_texture)
		drag_preview_texture.size = Vector2(0.1,0.1)  # No idea why this works
		var data = {
			"origin_node": self,
			"resource": resource
		}
		set_drag_preview(drag_preview_texture)
		return data
	else:
		return null

func _drop_data(at_position, data):
	if (data["origin_node"] != self) and (data["resource"]):
		var this_resource = resource
		set_resource(data["resource"])
		data["origin_node"].set_resource(this_resource)

func set_resource(resource: Resource):
	if self.resource != resource:
		self.resource = resource
		resource_changed.emit(resource)
		if resource:
			$Texture.texture = resource.icon_texture
		else:
			$Texture.texture = default_texture


func _on_ui_item_icon_mouse_entered():
	mouse_insight = true


func _on_ui_item_icon_mouse_exited():
	mouse_insight = false

func set_highlighted(value: bool):
	var panel: Panel = $Panel
	if value:
		panel.theme_type_variation = "HighlightedPanel"
	else:
		panel.theme_type_variation = "ItemBackgroundPanel"
		
