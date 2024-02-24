extends Control

@export var active: bool = false
@export var content: Control
@export var margin = 20
signal deactivated

func _ready():
	$Panel.size = size
	$Margin.size = size - Vector2(margin, margin)
	$Margin.position = Vector2(margin/2, margin/2)
	
	set_active(false)
	if content:
		set_content(content)

func set_active(value: bool):
	visible = value
	$Margin/MainLayout.visible = value
	active = value

func activate():
	set_active(true)

func deactivate():
	set_active(false)

func set_content(content: Control):
	content.reparent($Margin/MainLayout)
	content.size_flags_vertical = Control.SIZE_EXPAND
	content.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
