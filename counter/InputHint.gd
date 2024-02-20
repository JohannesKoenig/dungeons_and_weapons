class_name InputHint extends Sprite2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var input_type_resource: InputTypeResource = preload("res://Resources/input_type_resource.tres")
@export var controller_texture: Texture
@export var keyboard_texture: Texture
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	visible = false
	set_hint_texture()
	input_type_resource.type_changed.connect(set_hint_texture)
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func show_hint():
	set_hint_texture()
	visible = true

func hide_hint():
	visible = false

func set_hint_texture():
	if input_type_resource.is_controller:
		texture = controller_texture
	if input_type_resource.is_keyboard:
		texture = keyboard_texture
