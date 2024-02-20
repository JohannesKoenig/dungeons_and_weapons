class_name SkinBuilderGui extends HBoxContainer
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var skin_builder: SkinBuilder
var head_index = 0
var body_index = 0
var legs_index = 0
var button_click_player
var init_ready = false

@onready var tex: TextureRect = $TextureRect
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------

func _ready():
	button_click_player = $"/root/ButtonClick"
	skin_builder = SkinBuilder.new()
	tex.material = tex.material.duplicate()
	tex.material.set("shader_parameter/uv", tex.texture)
	tex.material.set("shader_parameter/head", skin_builder.heads[head_index])
	tex.material.set("shader_parameter/body", skin_builder.bodies[body_index])
	tex.material.set("shader_parameter/legs", skin_builder.legs[legs_index])
	init_ready = true
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------



func _on_head_l_pressed():
	button_click_player.play_click()
	head_index = (head_index - 1 + len(skin_builder.heads)) % len(skin_builder.heads)
	tex.material.set("shader_parameter/head", skin_builder.heads[head_index])

func _on_body_l_pressed():
	button_click_player.play_click()
	body_index = (body_index - 1 + len(skin_builder.bodies)) % len(skin_builder.bodies)
	tex.material.set("shader_parameter/body", skin_builder.bodies[body_index])


func _on_legs_l_pressed():
	button_click_player.play_click()
	legs_index = (legs_index - 1 + len(skin_builder.legs)) % len(skin_builder.legs)
	tex.material.set("shader_parameter/legs", skin_builder.legs[legs_index])


func _on_head_r_pressed():
	button_click_player.play_click()
	head_index = (head_index + 1 + len(skin_builder.heads)) % len(skin_builder.heads)
	tex.material.set("shader_parameter/head", skin_builder.heads[head_index])



func _on_body_r_pressed():
	button_click_player.play_click()
	body_index = (body_index + 1 + len(skin_builder.bodies)) % len(skin_builder.bodies)
	tex.material.set("shader_parameter/body", skin_builder.bodies[body_index])



func _on_legs_r_pressed():
	button_click_player.play_click()
	legs_index = (legs_index - 1 + len(skin_builder.legs)) % len(skin_builder.legs)
	tex.material.set("shader_parameter/legs", skin_builder.legs[legs_index])

func _on_focus():
	if init_ready:
		button_click_player.play_focus()
