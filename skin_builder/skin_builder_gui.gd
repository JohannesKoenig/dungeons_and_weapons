class_name SkinBuilderGui extends HBoxContainer
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var skin_builder: SkinBuilder
var head_index = 0
var body_index = 0
var legs_index = 0

@onready var tex: TextureRect = $TextureRect
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	skin_builder = SkinBuilder.new()
	tex.material = tex.material.duplicate()
	tex.material.set("shader_parameter/uv", tex.texture)
	tex.material.set("shader_parameter/head", skin_builder.heads[head_index])
	tex.material.set("shader_parameter/body", skin_builder.bodies[body_index])
	tex.material.set("shader_parameter/legs", skin_builder.legs[legs_index])

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------



func _on_head_l_pressed():
	head_index = (head_index - 1 + len(skin_builder.heads)) % len(skin_builder.heads)
	tex.material.set("shader_parameter/head", skin_builder.heads[head_index])

func _on_body_l_pressed():
	body_index = (body_index - 1 + len(skin_builder.bodies)) % len(skin_builder.bodies)
	tex.material.set("shader_parameter/body", skin_builder.bodies[body_index])


func _on_legs_l_pressed():
	legs_index = (legs_index - 1 + len(skin_builder.legs)) % len(skin_builder.legs)
	tex.material.set("shader_parameter/legs", skin_builder.legs[legs_index])


func _on_head_r_pressed():
	head_index = (head_index + 1 + len(skin_builder.heads)) % len(skin_builder.heads)
	tex.material.set("shader_parameter/head", skin_builder.heads[head_index])



func _on_body_r_pressed():
	body_index = (body_index + 1 + len(skin_builder.bodies)) % len(skin_builder.bodies)
	tex.material.set("shader_parameter/body", skin_builder.bodies[body_index])



func _on_legs_r_pressed():
	legs_index = (legs_index - 1 + len(skin_builder.legs)) % len(skin_builder.legs)
	tex.material.set("shader_parameter/legs", skin_builder.legs[legs_index])

