class_name AudioOptions extends VBoxContainer
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var menu_save_resource: MenuSaveResource = preload("res://savegame/menu_save_resource.tres")
@onready var ambient_slider: HSlider = $GridContainer/AmbientSlider
@onready var music_slider: HSlider = $GridContainer/MusicSlider
@onready var combat_slider: HSlider = $GridContainer/CombatSlider
@onready var ambient_label: Label = $GridContainer/AmbientValue
@onready var music_label: Label = $GridContainer/MusicValue
@onready var combat_label: Label = $GridContainer/CombatValue
var button_click_player
var init_ready = false
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	button_click_player = $"/root/ButtonClick"
	ambient_slider.value = menu_save_resource.ambient_sound_level
	music_slider.value = menu_save_resource.music_sound_level
	combat_slider.value = menu_save_resource.combat_sound_level
	ambient_label.text = str(menu_save_resource.ambient_sound_level)+"%"
	music_label.text = str(menu_save_resource.music_sound_level)+"%"
	combat_label.text = str(menu_save_resource.combat_sound_level)+"%"
	init_ready = true

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_ambient_slider_value_changed(value):
	if init_ready:
		button_click_player.play_focus()
	menu_save_resource.ambient_sound_level = value
	ambient_label.text = str(menu_save_resource.ambient_sound_level)+"%"

func _on_music_slider_value_changed(value):
	if init_ready:
		button_click_player.play_focus()
	menu_save_resource.music_sound_level = value
	music_label.text = str(menu_save_resource.music_sound_level)+"%"

func _on_combat_slider_value_changed(value):
	if init_ready:
		button_click_player.play_focus()
	menu_save_resource.combat_sound_level = value
	combat_label.text = str(menu_save_resource.combat_sound_level)+"%"
