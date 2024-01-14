extends TextureRect
class_name UIItemDragPreview

func _process(delta):
	global_position = get_global_mouse_position()
	if Input.is_action_just_released("Left Mouse"):
		delete()

func delete():
	pass
	queue_free()
